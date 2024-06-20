import 'package:app_state/app_state.dart';

import '../delegate.dart';

void initializeRouter(QuickDelegate delegate) {
  for (final tab in delegate.tabs) {
    delegate.pageStacks.addPageStack(
      tab.name,
      PageStack(
        bottomPage: delegate.bottomPages.get(tab),
        createPage: delegate.createPage,
      ),
    );
  }
}
