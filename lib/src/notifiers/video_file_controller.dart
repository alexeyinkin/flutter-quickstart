import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'file_controller.dart';

typedef StillListener = ValueSetter<XFile>;

class VideoFileController extends FileController {
  Uri? _lastRemoteUrl;
  Uint8List? _lastLocalBytes;

  VideoPlayerController? _playerController;
  ChewieController? _chewieController;

  final _stillListeners = <StillListener>{};

  VideoFileController({
    super.fileNameFormatter,
  });

  ChewieController? get chewieController => _chewieController;

  bool _needsToUpdateVideoController() {
    if (isMarkedForDeletion) {
      return true;
    }

    if (_lastRemoteUrl != remoteUrl) {
      return true;
    }

    if (_lastLocalBytes != localBytes) {
      return true;
    }

    return false;
  }

  @override
  void notifyListeners() {
    if (_needsToUpdateVideoController()) {
      unawaited(_disposeVideoControllers());
      _lastRemoteUrl = remoteUrl;
      _lastLocalBytes = localBytes;
      _createControllersIfNeed();
    }

    super.notifyListeners();
  }

  /// Sets [_playerController] and [_chewieController] to null immediately
  /// and awaits for them to be disposed.
  Future<void> _disposeVideoControllers() async {
    final oldChewieController = _chewieController;
    final oldPlayerController = _playerController;

    _chewieController = null;
    _playerController = null;

    oldChewieController?.dispose();
    await oldPlayerController?.dispose();
  }

  void _createControllersIfNeed() {
    final isCreated = _createVideoPlayerControllerIfNeed();
    if (!isCreated) {
      return;
    }

    _chewieController = ChewieController(
      videoPlayerController: _playerController!,
      useRootNavigator: false,
      customControls: MaterialControls(
        showPlayButton: true,
      ),
    );
  }

  bool _createVideoPlayerControllerIfNeed() {
    if (isMarkedForDeletion) {
      return false;
    }

    final localXFile = this.localXFile;
    if (localXFile != null) {
      _playerController = kIsWeb
          ? VideoPlayerController.networkUrl(Uri.parse(localXFile.path))
          : VideoPlayerController.file(File(localXFile.path));
      return true;
    }

    final remoteUrl = this.remoteUrl;
    if (remoteUrl != null) {
      _playerController = VideoPlayerController.networkUrl(remoteUrl);
      return true;
    }

    return false;
  }

  void addStillListener(StillListener listener) {
    _stillListeners.add(listener);
  }

  void removeScreenshotListener(StillListener listener) {
    _stillListeners.remove(listener);
  }

  Future<void> takeStill() async {
    final path = localXFile?.path ?? remoteUrl?.toString();
    if (path == null) {
      return;
    }

    final timeMs = (await _playerController?.position)?.inMilliseconds ?? 0;

    final bytes = await VideoThumbnail.thumbnailData(
      video: path,
      quality: 100,
      timeMs: timeMs,
    );

    if (bytes == null) {
      throw Exception('Taking a still at $timeMs milliseconds failed.');
    }

    final file = XFile.fromData(
      bytes,
      mimeType: 'image/png',
      name: 'still_$timeMs.png',
    );

    for (final listener in _stillListeners) {
      listener(file);
    }
  }
}
