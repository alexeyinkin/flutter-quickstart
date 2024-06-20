import 'package:app_state/app_state.dart';
import 'package:enum_map/enum_map.dart';
import 'package:flutter/widgets.dart';

import 'notifiers/settings.dart';
import 'router/page_factory.dart';
import 'router/page_stacks.dart' as ps;
import 'router/tab_enum.dart';
import 'util/iterable.dart';
import 'widgets/layout/padding.dart';
import 'widgets/layout/spacing.dart';
import 'widgets/menu/top_menu.dart';

abstract class QuickDelegate<T extends Enum> {
  UnmodifiableEnumMap<T, AbstractPage> get bottomPages;

  Widget getHeaderFiller() => const SizedBox.shrink();

  Widget getMenu() => QuickTopMenuWidget(
        delegate: this,
      );

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
