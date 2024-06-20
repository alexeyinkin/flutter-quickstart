import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../delegate.dart';

import '../theme/extension.dart';
import 'clickable.dart';

const _borderRadiusFraction = .1;
const _outline = .05;

class QuickLogoWidget extends StatelessWidget {
  final QuickDelegate delegate;
  final bool showText;
  final double size;

  const QuickLogoWidget({
    required this.delegate,
    required this.showText,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;

    return ClickableWidget(
      onTap: delegate.goHome,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(size * _borderRadiusFraction * (1 + _outline)),
            ),
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(size * _outline),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(size * _borderRadiusFraction),
                  ),
                  child: SizedBox(
                    height: size,
                    width: size,
                    child: const ColoredBox(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (showText) ...[
            SizedBox(width: size / 2),
            Text(delegate.title, style: ext.h1).tr(),
          ],
        ],
      ),
    );
  }
}
