import 'package:app_state/app_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_multi/easy_localization_multi.dart';
import 'package:easy_localization_yaml/easy_localization_yaml.dart';
import 'package:flutter/material.dart';

import 'pages/tabs/screen.dart';
import 'quickstart.dart';
import 'router/delegate.dart';
import 'theme/theme.dart';
import 'util/element.dart';

class QuickApp extends StatelessWidget {
  const QuickApp();

  @override
  Widget build(BuildContext context) {
    final delegate = QuickStart.delegate;
    final settingsNotifier = delegate.settingsNotifier;

    return EasyLocalization(
      supportedLocales: settingsNotifier.locales,
      path: 'unused',
      startLocale: settingsNotifier.locale,
      assetLoader: const MultiAssetLoader([
        YamlAssetLoader(
          directory: 'assets/translations',
          ignoreErrors: true,
          package: QuickStart.packageName,
        ),
      ]),
      fallbackLocale: settingsNotifier.locale,
      child: AnimatedBuilder(
        animation: settingsNotifier,
        builder: (context, _) {
          (context as Element).markNeedsBuildDescendants();
          return _MyApp();
        },
      ),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  final _routerDelegate = QuickRouterDelegate(
    QuickStart.delegate,
    QuickTabsScreen(delegate: QuickStart.delegate),
  );

  final _routeInformationParser = QuickStart.delegate.routeInformationParser;
  final _backButtonDispatcher =
      PageStacksBackButtonDispatcher(QuickStart.delegate.pageStacks);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      backButtonDispatcher: _backButtonDispatcher,
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      theme: quickThemeData,
      title: QuickStart.delegate.title,

      // Localization.
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
