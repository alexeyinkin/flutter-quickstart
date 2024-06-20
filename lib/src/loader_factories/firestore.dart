import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';
import 'package:model_interfaces/model_interfaces.dart';

import '../notifiers/toast.dart';

abstract class QuickFirestoreLoaderFactory<T extends WithId<String>,
    F extends AbstractFilter> extends AbstractFirestoreLoaderFactory<T, F> {
  @override
  void onError(Object error, StackTrace trace) {
    print(error); // ignore: avoid_print
    print(trace); // ignore: avoid_print

    toastNotifier.addThrowable(error);
  }
}
