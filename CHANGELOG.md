## 0.1.0-4.dev

* Using [google_sign_in](https://pub.dev/packages/google_sign_in) for Google sign-in on non-web.
* Calling `FirebaseAuth.signInWithProvider()` instead of `.signInWithPopup()` for non-web for providers other than Google.
* Added `BuildNumberWidget` to show the build number in settings if `--dart-define=build=...` is set.
* Added `QuickDelegate.getTabIcon()`.
* Renamed `QuickDelegate.authProviders` to `.authProviderIds`.
* Renamed `AuthenticationNotifier.signIn()` to `.signInWithProviderId()`.

## 0.1.0-3.dev

* Added `AuthenticationNotifier`.
* Added `QuickDelegate.addSpacing()`, `.buildFooter()`, `.buildLogo()`.
* Added `quickTr()` to a `Map<String, String>` extension to pick a translation from a map of localized strings.
* Exported `Toast`, `ToastType`, `ToastNotifer`, `Iterable` extensions, `H2`.
* Merging the app's own localization strings into easy_localization's.
* Made `Toast.description` optional.
* Changed the header padding.

## 0.1.0-2.dev

* Added `QuickDelegate.routeInformationParser`.
* Made `QuickScaffold.delegate` optional.
* Exported `QuickScaffold`, `QuickSettingsPage`, `QuickSettingsPath`,
  `QuickPageFactory`, `QuickThemeExtension`, `QuickPadding`, `SmallCircularProgressIndicator`. 

## 0.1.0-1.dev

* Initial release.
