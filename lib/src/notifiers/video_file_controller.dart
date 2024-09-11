import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

import 'file_controller.dart';

class VideoFileController extends FileController {
  Uri? _lastRemoteUrl;
  Uint8List? _lastLocalBytes;

  VideoPlayerController? _playerController;
  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  bool _needsToUpdateVideoController() {
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
}
