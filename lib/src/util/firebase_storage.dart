import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_future/progress_future.dart';

/// Uploads [bytes] as a file at [path].
UploadTask saveToFirebaseStorage(Uint8List bytes, {required String path}) {
  final fileRef = FirebaseStorage.instance.ref().child(path);
  return fileRef.putData(bytes);
}

/// Deletes the file at [path].
Future deleteInFirebaseStorage(String path) async {
  final fileRef = FirebaseStorage.instance.ref().child(path);
  return fileRef.delete();
}

extension QuickStartUploadTaskExtension on UploadTask {
  IntProgressFuture<void> toProgressFuture() {
    final updater = IntProgressUpdater(total: 1);

    snapshotEvents.listen((snapshot) {
      updater.total = snapshot.totalBytes;
      updater.setProgress(snapshot.bytesTransferred);
    });

    return IntProgressFuture.wrap(this, updater);
  }
}
