import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class SaveToEditPlaceholder extends StatelessWidget {
  const SaveToEditPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text('SaveToEditPlaceholder.text').tr(),
    );
  }
}
