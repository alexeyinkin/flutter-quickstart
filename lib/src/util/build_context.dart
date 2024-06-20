import 'package:flutter/widgets.dart';

import '../constants/sizes.dart';

extension BuildContextEstension on BuildContext {
  bool isMobileScreen() {
    final screenWidth = MediaQuery.of(this).size.width;
    return screenWidth < QuickSizes.minDesktopWidth;
  }
}
