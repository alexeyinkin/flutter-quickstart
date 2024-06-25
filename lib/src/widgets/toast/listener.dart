import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show FToast, ToastGravity;

import '../../delegate.dart';
import '../../models/toast.dart';
import '../../notifiers/toast.dart';
import 'toast.dart';

class ToastListenerWidget extends StatefulWidget {
  final Widget child;
  final QuickDelegate delegate;

  const ToastListenerWidget({
    super.key,
    required this.child,
    required this.delegate,
  });

  @override
  State<ToastListenerWidget> createState() => _ToastListenerWidgetState();
}

class _ToastListenerWidgetState extends State<ToastListenerWidget> {
  final _flutterToast = FToast();
  StreamSubscription? _toastSubscription;

  @override
  void initState() {
    super.initState();
    _flutterToast.init(context);
    _toastSubscription = toastNotifier.toasts.listen(_onToast);
  }

  Future<void> _onToast(Toast toast) async {
    _flutterToast.removeCustomToast();
    _flutterToast.showToast(
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 3),
      child: ToastWidget(toast, delegate: widget.delegate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    unawaited(_toastSubscription?.cancel());
    super.dispose();
  }
}
