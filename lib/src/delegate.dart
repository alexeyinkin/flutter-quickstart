import 'package:app_state/app_state.dart';
import 'package:enum_map/enum_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'notifiers/authentication.dart';
import 'notifiers/settings.dart';
import 'router/page_factory.dart';
import 'router/page_stacks.dart' as ps;
import 'router/route_information_parser.dart';
import 'router/tab_enum.dart';
import 'util/iterable.dart';
import 'widgets/layout/footer.dart';
import 'widgets/layout/padding.dart';
import 'widgets/layout/spacing.dart';
import 'widgets/logo/logo.dart';
import 'widgets/menu/top_menu.dart';

abstract class QuickDelegate<T extends Enum> {
  List<Widget> addSpacing(List<Widget> widgets) =>
      widgets.intersperse(spacing).toList(growable: false);

  late final authenticationNotifier = AuthenticationNotifier();

  final authProviderIds = [
    GoogleAuthProvider.PROVIDER_ID,
    AppleAuthProvider.PROVIDER_ID,
  ];

  UnmodifiableEnumMap<T, AbstractPage> get bottomPages;

  Widget buildFooter(BuildContext context) => const QuickFooterWidget();

  Widget buildLogo(
    BuildContext context, {
    required bool showText,
    required double size,
  }) =>
      QuickLogoWidget(
        delegate: this,
        showText: showText,
        size: size,
      );

  Widget buildHeaderFiller(BuildContext context) => const SizedBox.shrink();

  Widget buildMenu(BuildContext context) => QuickTopMenuWidget(
        delegate: this,
      );

  Icon buildTabIcon(BuildContext context, T tab) {
    return switch (tab.name) {
      'home' => const Icon(Icons.home),
      'settings' => const Icon(Icons.settings),
      _ => const Icon(Icons.circle_outlined),
    };
  }

  void goHome() {
    pageStacks.setCurrentStackKey(tabs.first.name);
    pageStacks.currentStack!.popUntilBottom();
  }

  List<Locale> get locales => quickLocales;

  Widget pad(Widget child) => QuickPadding(child: child);

  AbstractPage? createPage(
    String factoryKey,
    Map<String, dynamic> state,
  ) =>
      QuickPageFactory.createPage(factoryKey, state);

  PageStacks get pageStacks => ps.pageStacks;

  RouteInformationParser<Object> get routeInformationParser =>
      QuickRouteInformationParser();

  late final settingsNotifier = SettingsNotifier(locales: locales);

  Widget get spacing => const QuickSpacing();

  List<T> get tabs;

  String get title => 'QuickStart';

  T? get currentTab => tabs.byNameOrNull(pageStacks.currentStackKey);
}

class DefaultQuickDelegate extends QuickDelegate<QuickTabEnum> {
  @override
  UnmodifiableEnumMap<QuickTabEnum, AbstractPage> get bottomPages =>
      quickBottomPages;

  @override
  List<QuickTabEnum> get tabs => QuickTabEnum.values.toList(growable: false);
}
