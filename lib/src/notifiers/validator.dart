import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

/// An abstract validator for form data.
abstract class QuickValidator implements Listenable {
  /// Starts the validation and returns whether the data is valid.
  Future<bool> validate();

  /// Returns error messages associated with the [controller].
  List<String> getValidationMessages(Object controller);
}

mixin QuickValidatorMixin on ChangeNotifier implements QuickValidator {
  /// Messages showing when validation is complete.
  Map<Object, List<String>> _messages = <Object, List<String>>{};

  /// Messages as validation progresses and when it's complete.
  Map<Object, List<String>> _messagesInProgress = <Object, List<String>>{};

  Completer<bool> _latestValidationCompleter = Completer<bool>();

  /// Adds the error [message] and associates it with the [controller].
  void addValidationMessage(Object controller, String message) {
    _messagesInProgress[controller] = (_messagesInProgress[controller] ?? [])
      ..add(message);
  }

  /// Handles parallel validation attempts and notifications.
  ///
  /// Implement [validateFields] for the actual validation.
  @override
  Future<bool> validate() async {
    final completer = Completer<bool>();
    _latestValidationCompleter = completer;
    _messagesInProgress = {};
    await validateFields();

    if (_latestValidationCompleter != completer) {
      // A concurrent validation has started, discarding the result.
      return _latestValidationCompleter.future;
    }

    _stopListeningToInvalidControllers();
    _messages = _messagesInProgress;

    final isValid = _messages.isEmpty;

    if (!isValid) {
      _listenToInvalidControllers();
    }

    notifyListeners();
    _latestValidationCompleter.complete(isValid);
    return isValid;
  }

  Future<void> validateFields();

  void _stopListeningToInvalidControllers() {
    for (final controller in _messages.keys) {
      if (controller is Listenable) {
        controller.removeListener(_onInvalidControllerChanged);
      }
    }
  }

  void _listenToInvalidControllers() {
    for (final controller in _messages.keys) {
      if (controller is Listenable) {
        controller.addListener(_onInvalidControllerChanged);
      }
    }
  }

  Future<bool> _onInvalidControllerChanged() async {
    return validate();
  }

  @override
  List<String> getValidationMessages(Object controller) =>
      _messages[controller] ?? const [];

  /// Adds an error message if the Firestore [collectionReference]
  /// has a document with [id] and associates the message with the [controller].
  Future<void> validateFirestoreUniqueId(
    Object controller, {
    required String id,
    required CollectionReference collectionReference,
  }) async {
    if (id == '') {
      return;
    }

    final doc = await collectionReference.doc(id).get();

    if (doc.exists) {
      addValidationMessage(
        controller,
        'validation.duplicateId'.tr(namedArgs: {'id': id}),
      );
    }
  }

  /// Adds an error message if [value] is an empty string
  /// and associates the message with the [controller].
  void validateStringNotEmpty(Object controller, {required String value}) {
    if (value == '') {
      addValidationMessage(controller, 'validation.empty'.tr());
    }
  }
}
