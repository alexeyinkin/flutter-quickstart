import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyed_collection_widgets/keyed_collection_widgets.dart';

class EnumTabBar<T extends Enum> extends StatelessWidget {
  final List<T> values;

  const EnumTabBar.withDefaultController({
    super.key,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return KeyedTabBar.withDefaultController<T>(
      tabs: {
        for (final tab in values)
          tab: Tab(text: '$tab'.tr()),
      },
    );
  }
}
