This package allows you to create an app with:

- Routing.
- Tabs and independent navigation in each tab.
- Bottom navigation bar or top menu depending on the screen size.
- Language switch.

The UI details may change without notice.
Use this package when the functionality of your app is your priority
and you can tolerate some non-customizable opinionated looks to save a few days of development.

## Out-of-the-Box Examples

### Minimal

```dart
import 'package:flutter/widgets.dart';
import 'package:quickstart/quickstart.dart';

Future<void> main() async {
  await QuickStart.ensureInitialized();
  runApp(const QuickApp());
}
```

### Firebase

Passing a `FirebaseOptions` enables analytics.

```dart
import 'package:flutter/widgets.dart';
import 'package:quickstart/quickstart.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await QuickStart.ensureInitialized(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const QuickApp());
}
```

## Customizing

Subclass `QuickDelegate` and pass it to `ensureInitialized()` for customizations.

### Languages

To change the list of supported languages:

```dart
import 'package:flutter/widgets.dart';
import 'package:quickstart/quickstart.dart';

class AppDelegate extends DefaultQuickDelegate {
  @override
  List<Locale> get locales => [Locales.en_GB];
}

Future<void> main() async {
  await QuickStart.ensureInitialized(
    delegate: AppDelegate(),
  );

  runApp(const QuickApp());
}
```

When there's only one language, the switch does not how.



TODO: Expand.
