import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import '../../notifiers/video_file_controller.dart';
import '../clickable.dart';
import 'browse_button.dart';

const _placeholderSize = 96.0;

class VideoSelector extends StatelessWidget {
  final double aspectRatio;
  final VideoFileController controller;

  const VideoSelector({
    super.key,
    required this.aspectRatio,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    print('Building VideoSelector with aspectRatio $aspectRatio');
    return ListenableBuilder(
      listenable: Listenable.merge([controller, controller.chewieController]),
      builder: (context, _) {
        final w = _buildContentIfNonEmpty(context);

        if (w == null) {
          return _buildEmpty();
        }

        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            children: [
              Positioned.fill(
                child: w,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: BrowseButton(onPressed: controller.pickVideo),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return ClickableWidget(
      onTap: controller.pickVideo,
      child: const Icon(
        Icons.videocam_off_outlined,
        size: _placeholderSize,
      ),
    );
  }

  Widget? _buildContentIfNonEmpty(BuildContext context) {
    final c = controller.chewieController;
    if (c == null) {
      return null;
    }

    final themeData = Theme.of(context);
    final w = Theme(
      data: themeData.copyWith(platform: TargetPlatform.iOS),
      child: Chewie(controller: c),
    );

    final xfile = controller.localXFile;
    if (xfile != null) {
      return Opacity(
        opacity: controller.isChanged ? .5 : 1,
        child: w,
      );
    }

    return w;
  }
}
