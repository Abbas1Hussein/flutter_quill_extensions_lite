import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../bottom_sheet/size.dart';
import '../../dialogs/remove.dart';

class DesktopImageView extends StatelessWidget {
  final QuillController controller;

  final Image image;
  final String imageUrl;

  const DesktopImageView({
    super.key,
    required this.controller,
    required this.image,
    required this.imageUrl,
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
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        children: [
          SizeBottomSheet(controller: controller,image: image, imageUrl: imageUrl),
          RemoveOption(controller: controller),
        ],
      ),
    );
  }
}
