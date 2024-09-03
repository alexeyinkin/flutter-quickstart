import 'package:flutter/material.dart';

import '../../theme/extension.dart';
import '../layout/padding.dart';

class FramedColumnWidget extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onAddPressed;
  final String? title;

  const FramedColumnWidget({
    super.key,
    required this.children,
    this.onAddPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: ext.headerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          ..._buildHeader(ext),
          ...children,
        ],
      ),
    );
  }

  List<Widget> _buildHeader(QuickThemeExtension ext) {
    if (title == null && onAddPressed == null) return const [];

    return [
      ColoredBox(
        color: ext.headerColor,
        child: Row(
          children: [
            Expanded(
              child: QuickPadding(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: ext.onHeaderColor),
                ),
              ),
            ),
            if (onAddPressed != null)
              IconButton(
                icon: const Icon(Icons.add),
                color: ext.onHeaderColor,
                onPressed: onAddPressed,
              ),
          ],
        ),
      ),
    ];
  }
}
