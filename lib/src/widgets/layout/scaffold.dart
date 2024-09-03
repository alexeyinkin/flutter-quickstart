import 'package:flutter/material.dart';
import 'package:multi_animated_builder/multi_animated_builder.dart';

import '../../delegate.dart';
import '../../quickstart.dart';
import '../../theme/extension.dart';
import '../../theme/theme.dart';
import '../../util/build_context.dart';
import '../../util/iterable.dart';
import '../loading/small_circular_progress_indicator.dart';
import '../logo/logo_clickable_wrapper.dart';
import 'constrained_width.dart';
import 'horizontal_black_line.dart';

class QuickScaffold extends StatelessWidget {
  final Widget body;
  final BodySize bodySize;
  final WidgetBuilder? builder;
  final QuickDelegate? delegate;
  final double? maxWidth;
  final List<Listenable> notifiers;
  final VoidCallback? onSavePressed;
  final bool padding;

  const QuickScaffold({
    required this.body,
    required this.bodySize,
    this.delegate,
    this.maxWidth,
    this.onSavePressed,
    this.padding = true,
  })  : builder = null,
        notifiers = const [];

  const QuickScaffold.builder({
    required this.builder,
    required this.bodySize,
    this.delegate,
    this.maxWidth,
    this.notifiers = const [],
    this.onSavePressed,
    this.padding = true,
  }) : body = const SizedBox.shrink();

  const QuickScaffold.loading({
    this.delegate,
    this.maxWidth,
    this.padding = true,
  })  : bodySize = BodySize.infinite,
        body = const Center(
          child: SmallCircularProgressIndicator(),
        ),
        builder = null,
        notifiers = const [],
        onSavePressed = null;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileScreen();
    final delegate = this.delegate ?? QuickStart.delegate;

    Widget child = body;

    if (notifiers.isNotEmpty) {
      child = MultiAnimatedBuilder(
        animations: notifiers,
        builder: builder!,
      );
    }

    if (maxWidth != null) {
      child = ConstrainedWidthWidget(
        maxWidth: maxWidth!,
        child: child,
      );
    }

    if (padding) {
      child = delegate.pad(child);
    }

    child = switch (bodySize) {
      BodySize.finite => SingleChildScrollView(
          child: Column(
            children: [
              child,
              delegate.buildFooter(context),
            ],
          ),
        ),
      BodySize.infinite => Column(
          children: [
            Expanded(child: child),
            delegate.buildFooter(context),
          ],
        ),
    };

    return Stack(
      children: [
        Scaffold(
          body: ColoredBox(
            color: QuickColors.colorBlack,
            child: SafeArea(
              child: ColoredBox(
                color: QuickColors.colorWhite,
                child: Column(
                  children: [
                    if (isMobile)
                      _NarrowHeader(
                        delegate: delegate,
                        onSavePressed: onSavePressed,
                      )
                    else
                      _WideHeader(
                        delegate: delegate,
                        onSavePressed: onSavePressed,
                      ),
                    const HorizontalBlackLine(),
                    Expanded(
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // if (EnvironmentBanner.isShowing) const EnvironmentBanner(),
      ],
    );
  }
}

class _NarrowHeader extends StatelessWidget {
  final QuickDelegate delegate;
  final VoidCallback? onSavePressed;

  const _NarrowHeader({
    required this.delegate,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;

    return ColoredBox(
      color: ext.headerColor,
      child: delegate.pad(
        Row(
          children: [
            LogoClickableWrapper(
              delegate: delegate,
              child: delegate.buildLogo(
                context,
                size: 44, // Empirical from search field height.
                showText: false,
              ),
            ),
            Expanded(
              child: delegate.buildHeaderFiller(context),
            ),
            if (onSavePressed != null)
              _SaveButton(ext: ext, onPressed: onSavePressed!),
          ].intersperse(delegate.spacing).toList(growable: true),
        ),
      ),
    );
  }
}

class _WideHeader extends StatelessWidget {
  final QuickDelegate delegate;
  final VoidCallback? onSavePressed;

  const _WideHeader({
    required this.delegate,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;

    return ColoredBox(
      color: ext.headerColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            LogoClickableWrapper(
              delegate: delegate,
              child: delegate.buildLogo(
                context,
                size: 40,
                showText: true,
              ),
            ),
            Expanded(
              child: delegate.buildHeaderFiller(context),
            ),
            delegate.buildMenu(context),
            if (onSavePressed != null)
              _SaveButton(ext: ext, onPressed: onSavePressed!),
          ].intersperse(const SizedBox(width: 20)).toList(growable: false),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final QuickThemeExtension ext;
  final VoidCallback onPressed;

  const _SaveButton({
    required this.ext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.check, color: ext.onHeaderColor),
    );
  }
}

enum BodySize {
  /// The body is finite and defines its own height.
  /// It is Container, Column, a shrink-wrapped ListView, etc.
  /// The footer goes after the body and is not initially visible on long pages.
  finite,

  /// The body is infinite and must be given a finite viewport.
  /// It is a non-shrink-wrapped ListView, a SingleChildScrollView,
  /// a column with Expanded, etc.
  /// The footer sticks to the bottom and is always visible.
  infinite,
}
