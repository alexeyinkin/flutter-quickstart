import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_future/progress_future.dart';

import '../util/firebase_storage.dart';
import '../util/mime.dart';
import 'toast.dart';

typedef FileNameFormatter = String Function({
  required Digest digest,
  required String extension,
});

class FileController extends ChangeNotifier {
  final FileNameFormatter? fileNameFormatter;
  Uri? _remoteUrl;
  String? _remoteFileName;
  XFile? _localXFile;
  Uint8List? _localBytes;
  bool _isChanged = false;
  bool _isMarkedForDeletion = false;

  FileController({this.fileNameFormatter});

  Uri? get remoteUrl => _remoteUrl;

  XFile? get localXFile => _localXFile;

  Uint8List? get localBytes => _localBytes;

  /// Sets the URL to be shown.
  ///
  /// [fileName] is the file name to be returned by `fileName` getter.
  /// It's separate because you may use rewriting, encoding, parameters, etc.
  /// When you get the file name from this controller, it's a good practice that
  /// round-trip file name is not parsed from the URL but is returned as is.
  void setRemoteUrl(Uri? newValue, {required String? fileName}) {
    _remoteUrl = newValue;
    _remoteFileName = fileName;
    notifyListeners();
  }

  bool get isChanged => _isChanged;

  bool get isMarkedForDeletion => _isMarkedForDeletion;

  bool get isEmpty =>
      _isMarkedForDeletion || _remoteUrl == null && localXFile == null;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );

      if (file == null) {
        _onError(null);
        return;
      }

      await setXFile(file);
    } on PlatformException catch (ex) {
      _onError(ex);
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();

    try {
      final file = await picker.pickVideo(
        source: ImageSource.gallery,
      );

      if (file == null) {
        _onError(null);
        return;
      }

      await setXFile(file);
    } on PlatformException catch (ex) {
      _onError(ex);
    }
  }

  /// Returns the file name to be saved to, or the original file name.
  String? get fileName {
    if (_isMarkedForDeletion) {
      return null;
    }

    if (_localBytes == null) {
      return _remoteFileName;
    }

    if (fileNameFormatter != null) {
      return fileNameFormatter!(
        digest: md5.convert(_localBytes!),
        extension: extension!,
      );
    }

    return _localXFile!.name;
  }

  void _onError(Object? ex) {
    toastNotifier.addThrowable(ex ?? 'Unknown Error');
  }

  Future<void> setXFile(XFile file) async {
    _isMarkedForDeletion = false;
    _localBytes = await file.readAsBytes();
    _localXFile = file;
    _isChanged = true;
    notifyListeners();
  }

  void markForDeletion() {
    _localBytes = null;
    _localXFile = null;

    if (_remoteUrl == null) {
      _isChanged = false;
    } else {
      _isMarkedForDeletion = true;
      _isChanged = true;
    }

    notifyListeners();
  }

  String? get extension {
    final mimeType = _localXFile?.mimeType;
    if (mimeType != null) {
      print('Returning extension ${extensionFromMime(mimeType)} for $mimeType');
      return extensionFromMime(mimeType);
    }

    final name = _localXFile?.name;
    if (name != null) {
      return '.' + name.split('.').last;
    }

    throw Exception('Cannot determine the extension of the file.');
  }

  /// Saves the file to [path].
  ///
  /// If [oldPath] is given then:
  /// - If it's different from [path] then the file at [oldPath] is deleted
  ///   after the successful upload.
  /// - If [isMarkedForDeletion] then the file at [oldPath] is deleted.
  ///
  /// Returns the future that tracks the bytes progress.
  IntProgressFuture<void> saveToFirebase(String? path, {String? oldPath}) {
    if (_isMarkedForDeletion) {
      if (oldPath == null) {
        return IntProgressFuture.value(null);
      }

      // ignore: discarded_futures
      final future = deleteInFirebaseStorage(oldPath);
      return IntProgressFuture.wrapDelayedWithoutProgress(future);
    }

    if (path == null) {
      return IntProgressFuture.value(null);
    }

    final bytes = _localBytes;
    if (bytes == null) {
      return IntProgressFuture.value(null);
    }

    final result = saveToFirebaseStorage(bytes, path: path).toProgressFuture();

    if (oldPath != null && oldPath != path) {
      return result.then((_) async => deleteInFirebaseStorage(oldPath));
    }

    return result;
  }
}
