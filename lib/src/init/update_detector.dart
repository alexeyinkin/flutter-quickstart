import '../loader_factories/global.dart';
import '../models/global.dart';

void initializeUpdateDetector() {
  final bloc = QuickGlobalFirestoreLoaderFactory.instance
      .liveByIdBloc(QuickGlobal.singleId);

  bloc.states.listen(
    (event) {
      final model = event.model;
      if (model == null) {
        return;
      }

      // ignore: avoid_print
      print('Minimal supported version: ${model.versions.min}');
    },
  );
}
