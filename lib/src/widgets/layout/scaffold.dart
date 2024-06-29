import 'package:flutter/material.dart';

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
  final QuickDelegate? delegate;
  final double? maxWidth;
  final bool padding;

  const QuickScaffold({
    required this.body,
    required this.bodySize,
    this.delegate,
    this.maxWidth,
    this.padding = true,
  });

  const QuickScaffold.loading({
    this.delegate,
    this.maxWidth,
    this.padding = true,
  })  : bodySize = BodySize.infinite,
        body = const Center(
          child: SmallCircularProgressIndicator(),
        );

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileScreen();
    final delegate = this.delegate ?? QuickStart.delegate;

    Widget child = body;

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
                      _NarrowHeader(delegate: delegate)
                    else
                      _WideHeader(delegate: delegate),
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

  const _NarrowHeader({
    required this.delegate,
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
              child: delegate.getHeaderFiller(),
            ),
          ].intersperse(delegate.spacing).toList(growable: true),
        ),
      ),
    );
  }
}

class _WideHeader extends StatelessWidget {
  final QuickDelegate delegate;

  const _WideHeader({
    required this.delegate,
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
            const SizedBox(width: 20),
            Expanded(
              child: delegate.getHeaderFiller(),
            ),
            const SizedBox(width: 20),
            delegate.getMenu(),
          ],
        ),
      ),
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
