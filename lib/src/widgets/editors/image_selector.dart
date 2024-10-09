import 'package:flutter/material.dart';

import '../../notifiers/file_controller.dart';
import '../../quickstart.dart';
import '../buttons/browse.dart';
import '../buttons/delete.dart';
import '../clickable.dart';
import '../loading/small_circular_progress_indicator.dart';

const _placeholderSize = 96.0;

class ImageSelector extends StatelessWidget {
  final FileController controller;

  const ImageSelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final w = _buildContentIfNonEmpty();

        if (w == null) {
          return _buildEmpty();
        }

        return Stack(
          children: [
            w,
            Positioned(
              right: 10,
              top: 10,
              child: Row(
                children: QuickStart.delegate.addSpacing([
                  DeleteButton(onPressed: controller.markForDeletion),
                  BrowseButton(onPressed: controller.pickImage),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmpty() {
    return ClickableWidget(
      onTap: controller.pickImage,
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: _placeholderSize,
      ),
    );
  }

  Widget? _buildContentIfNonEmpty() {
    if (controller.isMarkedForDeletion) {
      return null;
    }

    final xfile = controller.localXFile;
    if (xfile != null) {
      final bytes = controller.localBytes;
      if (bytes == null) {
        return const SmallCircularProgressIndicator();
      }

      return Opacity(
        opacity: controller.isChanged ? .5 : 1,
        child: Image.memory(bytes),
      );
    }

    final url = controller.remoteUrl;
    if (url != null) {
      return Image.network(url.toString());
    }

    return null;
  }
}
