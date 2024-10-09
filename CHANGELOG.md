## 0.1.0-10.dev

* Added `SlugEditingController`, `SlugTextField`, `Validator.validateSlug()`.
* Added `Validator.validateStringLength()`.
* Narrow view in `SettingsTableWidget`.
* Taking stills in `VideoFileController`.
* Fixed `ImageSelector` for iOS.

## 0.1.0-9.dev

* Added `QuickValidator` and `QuickValidatorMixin`.
* Added `FileController.saveToFirebase()`, `.markForDeletion()`, `.extension`, `.fileName`, `.setXFile()`.
* Added `GroupedCollectionController.setItemsAndGroups()`.
* Added `QuickScaffold.fillter`.
* Added "Don't Save" button wherever "Save" button shows.
* Made `routerDelegate` a public variable.
* Added `UploadTask.toProgressFuture()` extension method.
* Added `String.toPseudoRandomColor()` extension method.
* Added `DeleteButton` to `ImageSelector` and `VideoSelector`, added glow around the selectors' buttons.
* Added `SaveToEditPlaceholder`, `ProgressDialog`, `QuickDialog`.
* Added `SmallCircularProgressIndicator.value`.
* Added `LoaderValueNotifier`, `LoaderDropdownButton`.
* Added `saveToFirebaseStorage()`, `deleteInFirebaseStorage()`, `UploadTask.toProgressFuture()` extension method.
* Added `String.toPseudoRandomColor()` extension method.
* Changed how `EasyLocalization` listens to the language from `SettingsNotifier`.

## 0.1.0-8.dev

* Added `FileController`, `VideoFileController`, `ImageSelector`, `VideoSelector`.
* Removed `firebase_analytics` because of [a bug](https://github.com/flutter/flutter/issues/154733).

## 0.1.0-7.dev

* Renamed `GroupedGridController` to `GroupedCollectionController`.
* Added `LazyLoadListView`, `MultilingualTextEditingController`, `QuickEditorMode`, `QuickSettingsContent`, `QuickStartLocaleIterableExtension`.

## 0.1.0-6.dev

* Support [model_fetch](https://pub.dev/packages/model_fetch) 0.6.0-5.dev and [model_fetch_firestore](https://pub.dev/packages/model_fetch_firestore) 0.6.0-6.dev.
* Added `AuthenticationBuilder`.
* Added `SmallCircularProgressIndicator` to `GroupedGrid`.

## 0.1.0-5.dev

* Added `GroupedGridWidget`, `GroupedGridController`, and model groupers.
* When clicked the logo, first scroll to the top if possible.

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
