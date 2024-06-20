import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../enums/toast_type.dart';
import '../models/toast.dart';

final toastNotifier = ToastNotifier();

class ToastNotifier {
  final _controller = StreamController<Toast>();

  Stream<Toast> get toasts => _controller.stream;

  void add(Toast toast) {
    _controller.add(toast);
  }

  void addThrowable(Object error) {
    add(
      Toast(
        title: 'toasts.error'.tr(),
        description: error.toString(),
        type: ToastType.error,
      ),
    );
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}
