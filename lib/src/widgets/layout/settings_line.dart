import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:model_editors/model_editors.dart';

import '../../notifiers/validator.dart';
import '../../util/build_context.dart';

class SettingsLineWidget extends StatelessWidget {
  final Widget child;
  final String? keyPrefix;
  final String textKey;
  final QuickValidator? validator;

  const SettingsLineWidget({
    required this.child,
    required this.keyPrefix,
    required this.textKey,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return context.isMobileScreen() ? _buildNarrow() : _buildWide();
  }

  Widget _buildNarrow() {
    return switch (child) {
      MaterialCheckbox() =>
        _buildNarrowMaterialCheckbox(child as MaterialCheckbox),
      _ => _buildNarrowDefault(),
    };
  }

  Widget _buildNarrowMaterialCheckbox(MaterialCheckbox child) {
    return MaterialCheckboxWithText(
      controller: child.controller,
      text: _getText(),
    );
  }

  Widget _buildNarrowDefault() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNarrowTitle(),
        const SizedBox(height: 5),
        _buildValue(),
      ],
    );
  }

  Widget _buildNarrowTitle() {
    return Text(_getText() + ':');
  }

  Widget _buildWide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildWideTitle(),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: _buildValue(),
        ),
      ],
    );
  }

  Widget _buildWideTitle() {
    return Text(
      _getText() + ':',
      textAlign: TextAlign.end,
    );
  }

  String _getText() {
    return (keyPrefix == null ? textKey : tr('$keyPrefix.$textKey'));
  }

  Widget _buildValue() {
    final controller = _getChildController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(alignment: Alignment.topLeft, child: child),
        if (controller != null && validator != null)
          ListenableBuilder(
            listenable: validator!,
            builder: (context, child) {
              final themeData = Theme.of(context);
              final messages = validator!.getValidationMessages(controller);

              if (messages.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final message in messages)
                    Text(
                      message,
                      style: themeData.inputDecorationTheme.errorStyle,
                    ),
                ],
              );
            },
          ),
      ],
    );
  }

  ChangeNotifier? _getChildController() {
    final child = this.child;

    return switch (child) {
      // TODO: Handle all standard widgets with controllers.
      TextField() => child.controller,
      // TODO: File a bug: we should not need a cast here (Dart 3.5.3):
      ControllerWidget() => (child as ControllerWidget).controller,
      _ => null,
    };
  }
}
