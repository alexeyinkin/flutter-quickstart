import 'package:flutter/material.dart';

enum _SizeSource {
  manual,
  iconTheme,
}

/// A semi-transparent white circle around the [child].
class GlowWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final _SizeSource _sizeSource;

  const GlowWidget({
    super.key,
    required this.child,
    required this.size,
  }) : _sizeSource = _SizeSource.manual;

  const GlowWidget.defaultSizeIconButton({
    super.key,
    required this.child,
  })  : size = 1,
        _sizeSource = _SizeSource.iconTheme;

  @override
  Widget build(BuildContext context) {
    final size = _getSize(context);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0x40ffffff),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  double _getSize(BuildContext context) {
    switch (_sizeSource) {
      case _SizeSource.manual:
        return size;
      case _SizeSource.iconTheme:
        final themeData = Theme.of(context);

        // The default from the doc comment on `size` + `IconButton.padding`.
        return (themeData.iconTheme.size ?? 24) + 16;
    }
  }
}
