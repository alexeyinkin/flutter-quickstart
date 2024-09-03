import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../quickstart.dart';
import '../../../widgets/auth/authenticated_or_not.dart';
import '../../../widgets/auth/profile_sign_out.dart';
import '../../../widgets/language/switch.dart';
import '../../../widgets/layout/h2.dart';
import '../../../widgets/layout/settings_table.dart';
import 'build_number.dart';

class QuickSettingsContent extends StatelessWidget {
  const QuickSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final delegate = QuickStart.delegate;

    return Column(
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
          keyPrefix: 'settings',
          children: {
            if (delegate.settingsNotifier.locales.length > 1)
              'language': LanguageSwitchWidget(
                delegate: delegate,
                showText: true,
              ),
            if (BuildNumberWidget.isBuildNumberSet)
              'build': const BuildNumberWidget(),
          },
        ),
      ]),
    );
  }
}
