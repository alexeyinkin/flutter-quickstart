import 'package:flutter/widgets.dart';

const _variable = 'build';

class BuildNumberWidget extends StatelessWidget {
  const BuildNumberWidget();

  // ignore: do_not_use_environment
  static const isBuildNumberSet = bool.hasEnvironment(_variable);

  @override
  Widget build(BuildContext context) {
    // ignore: do_not_use_environment
    return const Text(String.fromEnvironment(_variable));
  }
}
