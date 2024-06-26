import 'package:flutter/material.dart';

import '../../delegate.dart';
import '../../enums/toast_type.dart';
import '../../models/toast.dart';

class ToastWidget extends StatelessWidget {
  final QuickDelegate delegate;
  final Toast toast;

  const ToastWidget(
    this.toast, {
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: toast.type == ToastType.error ? colors.error : colors.info,
      child: delegate.pad(
        Column(
          children: [
            Text(toast.title),
            if (toast.description != null) ...[
              delegate.spacing,
              Text(toast.description!),
            ],
          ],
        ),
      ),
    );
  }
}
