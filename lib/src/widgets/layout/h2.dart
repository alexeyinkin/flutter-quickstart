import 'package:flutter/material.dart';

import '../../theme/extension.dart';

class H2Widget extends StatelessWidget {
  final String text;

  const H2Widget(this.text);

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>();

    return Text(
      text,
      style: ext?.h2,
      textAlign: TextAlign.center,
    );
  }
}
