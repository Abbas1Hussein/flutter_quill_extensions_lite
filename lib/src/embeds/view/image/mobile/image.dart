import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../dialogs/copy.dart';
import '../../dialogs/remove.dart';
import '../../dialogs/resize.dart';

class MobileImageView extends StatelessWidget {
  final QuillController controller;

  final Image image;

  const MobileImageView({
    super.key,
    required this.controller,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _buildOptionDialog(context),
      child: image,
    );
  }

  void _buildOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          children: [
            ResizeOption(
              controller: controller,
              width: image.width,
              height: image.height,
            ),
            CopyOption(controller: controller),
            RemoveOption(controller: controller)
          ],
        ),
      ),
    );
  }
}
