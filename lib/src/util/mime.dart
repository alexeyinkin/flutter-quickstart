import 'package:mime/mime.dart' as mime;

const _overrides = {
  'image/jpeg': 'jpeg',
};

String? extensionFromMime(String mimeType) {
  return _overrides[mimeType] ?? mime.extensionFromMime(mimeType);
}
