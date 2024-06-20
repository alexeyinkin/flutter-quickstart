import 'package:enum_map/enum_map.dart';

import '../theme/theme.dart';

@MakeUnmodifiableMap()
enum ToastType {
  error,
  info,
}

// TODO(alexeyinkin): Move to toast.dart when a map is visible outside, https://github.com/dart-lang/sdk/issues/56040
final colors = UnmodifiableToastTypeMap(
  error: QuickColors.error,
  info: QuickColors.notificationColor,
);
