import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'horizontal_black_line.dart';

class QuickFooterWidget extends StatelessWidget {
  const QuickFooterWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HorizontalBlackLine(),
        SizedBox(
          height: 50,
          child: Center(
            child: const Text('common.footer').tr(),
          ),
        ),
      ],
    );
  }
}
