import 'package:flutter/material.dart';
import 'package:progress_future/progress_future.dart';

import '../../router/delegate.dart';
import 'bytes_formatter.dart';
import 'small_circular_progress_indicator.dart';

typedef ProgressFormatter<R, N extends num> = String Function(
  ProgressFuture<R, N> future,
);

/// A dialog that shows the progress of a [Future].
class ProgressDialog extends StatelessWidget {
  final WidgetBuilder builder;

  const ProgressDialog._({
    super.key,
    required this.builder,
  });

  /// Shows a dialog with a loading indicator with unknown progress
  /// that stays on the screen until the [future] completes.
  static Future<void> showUnknown(Future future) async {
    return _showDialog(
      future,
      builder: (context) => const SmallCircularProgressIndicator(),
    );
  }

  /// Shows a dialog with a loading indicator with the progress of the [future]
  /// and a text of the progress formatted with the [formatter]
  /// which stays on the screen until [future] completes.
  static Future<void> show<R, N extends num>(
    ProgressFuture<R, N> future, {
    ProgressFormatter<R, N>? formatter,
  }) async {
    return _showDeterministicDialog(
      future,
      indicatorBuilder: formatter == null
          ? (context) => SmallCircularProgressIndicator(
                value: future.fraction,
              )
          : (context) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmallCircularProgressIndicator(
                      value: future.fraction,
                    ),
                    Text(formatter(future)),
                  ],
                ),
              ),
    );
  }

  /// Shows a dialog with a loading indicator with the progress of the [future]
  /// and a text of the progress formatted as bytes in the appropriate units
  /// which stays on the screen until [future] completes.
  static Future<void> showBytes<R>(ProgressFuture<R, int> future) async {
    return show<R, int>(future, formatter: bytesFormatter);
  }

  static Future<void> _showDeterministicDialog(
    ProgressFuture future, {
    required WidgetBuilder indicatorBuilder,
  }) {
    return _showDialog(
      future,
      builder: (context) => StreamBuilder(
        stream: future.events,
        builder: (context, snapshot) => indicatorBuilder(context),
      ),
    );
  }

  static Future<void> _showDialog(
    Future future, {
    required WidgetBuilder builder,
  }) async {
    bool isShown = true;

    final dialogFuture = showDialog<void>(
      context: routerDelegate.navigatorKey!.currentContext!,
      builder: (context) => ProgressDialog._(
        builder: builder,
      ),
      barrierDismissible: false,
      barrierColor: Color(0x40000000),
    );

    dialogFuture.whenComplete(() {
      isShown = false;
    });

    future.whenComplete(() {
      if (isShown) {
        routerDelegate.navigatorKey!.currentState!.pop();
      }
    });

    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: builder(context),
      ),
    );
  }
}
