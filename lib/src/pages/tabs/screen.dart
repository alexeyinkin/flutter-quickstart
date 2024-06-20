import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';

import '../../delegate.dart';
import '../../util/build_context.dart';
import '../../widgets/layout/bottom_navigation_bar.dart';
import '../../widgets/loading/small_circular_progress_indicator.dart';

class QuickTabsScreen<T extends Enum> extends StatefulWidget {
  final QuickDelegate<T> delegate;

  const QuickTabsScreen({
    required this.delegate,
  });

  @override
  State<QuickTabsScreen<T>> createState() => _QuickTabsScreenState<T>();
}

class _QuickTabsScreenState<T extends Enum> extends State<QuickTabsScreen<T>> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
      focusNode: _focusNode,
      selectionControls: materialTextSelectionControls,
      child: StreamBuilder(
        stream: widget.delegate.pageStacks.events,
        builder: (context, snapshot) => _buildOnEvent(context),
      ),
    );
  }

  Widget _buildOnEvent(BuildContext context) {
    final delegate = widget.delegate;
    final tab = delegate.currentTab;

    if (tab == null) return const SmallCircularProgressIndicator();

    return Scaffold(
      body: KeyedStack<T>(
        itemKey: tab,
        children: delegate.pageStacks.pageStacks.map(
          (tabString, stack) => MapEntry(
            delegate.tabs.byName(tabString),
            PageStackNavigator(key: ValueKey(tabString), stack: stack),
          ),
        ),
      ),
      bottomNavigationBar: context.isMobileScreen()
          ? QuickBottomNavigationBar(delegate: delegate)
          : null,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
