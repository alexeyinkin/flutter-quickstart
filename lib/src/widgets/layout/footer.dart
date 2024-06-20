import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class QuickFooterWidget extends StatelessWidget {
  const QuickFooterWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: const Text('common.footer').tr(),
      ),
    );
  }
}
