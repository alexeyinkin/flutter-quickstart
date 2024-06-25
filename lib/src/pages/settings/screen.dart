import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import '../../quickstart.dart';
import '../../widgets/auth/authenticated_or_not.dart';
import '../../widgets/auth/profile_sign_out.dart';
import '../../widgets/language/switch.dart';
import '../../widgets/layout/h2.dart';
import '../../widgets/layout/scaffold.dart';
import 'state.dart' as s;
import 'widgets/table.dart';

class QuickSettingsScreen extends StatelessWidget {
  final s.QuickSettingsNotifier notifier;

  const QuickSettingsScreen(this.notifier);

  @override
  Widget build(BuildContext context) {
    final delegate = QuickStart.delegate;

    return QuickScaffold(
      maxWidth: QuickSizes.maxTextPageWidth,
      bodySize: BodySize.infinite,
      body: Column(
        children: delegate.addSpacing([
          H2Widget(
            'menu.settings'.tr(),
          ),
          AuthenticatedOrNotWidget(
            authenticatedBuilder: (context, firebaseUser) {
              return ProfileSignOutWidget(firebaseUser: firebaseUser);
            },
          ),
          SettingsTableWidget(
            children: {
              if (delegate.settingsNotifier.locales.length > 1)
                'language': LanguageSwitchWidget(
                  delegate: delegate,
                  showText: true,
                ),
            },
            delegate: delegate,
          ),
        ]),
      ),
    );
  }
}
