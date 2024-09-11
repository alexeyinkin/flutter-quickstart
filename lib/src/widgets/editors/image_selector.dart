import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../notifiers/file_controller.dart';
import '../clickable.dart';
import 'browse_button.dart';

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
              right: 0,
              top: 0,
              child: BrowseButton(onPressed: controller.pickImage),
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
    final xfile = controller.localXFile;
    if (xfile != null) {
      return Opacity(
        opacity: controller.isChanged ? .5 : 1,
        child:
            kIsWeb ? Image.network(xfile.path) : Image.file(File(xfile.path)),
      );
    }

    final url = controller.remoteUrl;
    if (url != null) {
      return Image.network(url.toString());
    }

    return null;
  }
}
