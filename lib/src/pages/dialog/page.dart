import 'package:app_state/app_state.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'state.dart';
import 'widgets/confirm.dart';
import 'widgets/input.dart';

class QuickDialogPage<R>
    extends StatefulMaterialPage<R, QuickDialogNotifier<R>> {
  QuickDialogPage({
    required super.createScreen,
  }) : super(
          key: ValueKey<String>(clock.now().toString()),
          state: QuickDialogNotifier<R>(),
        );

  static QuickDialogPage<bool> confirm({required String title}) =>
      QuickDialogPage<bool>(
        createScreen: (s) => ConfirmDialog(
          callback: s.pop,
          title: title,
        ),
      );

  static QuickDialogPage<String> input({required String title}) =>
      QuickDialogPage<String>(
        createScreen: (s) => InputDialog(
          callback: s.pop,
          title: title,
        ),
      );

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      builder: (context) => child,
      settings: this,
    );
  }
}
