import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'toast.dart';

class FileController extends ChangeNotifier {
  Uri? _remoteUrl;
  XFile? _localXFile;
  Uint8List? _localBytes;
  bool _isChanged = false;

  Uri? get remoteUrl => _remoteUrl;

  XFile? get localXFile => _localXFile;

  Uint8List? get localBytes => _localBytes;

  set remoteUrl(Uri? newValue) {
    _remoteUrl = newValue;
    notifyListeners();
  }

  bool get isChanged => _isChanged;

  bool get isEmpty => _remoteUrl == null && localXFile == null;

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

      await _setFile(file);
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

      await _setFile(file);
    } on PlatformException catch (ex) {
      _onError(ex);
    }
  }

  void _onError(Object? ex) {
    toastNotifier.addThrowable(ex ?? 'Unknown Error');
  }

  Future<void> _setFile(XFile file) async {
    _localBytes = await file.readAsBytes();
    _localXFile = file;
    _isChanged = true;
    notifyListeners();
  }
}
