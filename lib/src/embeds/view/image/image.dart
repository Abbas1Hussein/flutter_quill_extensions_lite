import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../dialogs/remove.dart';
import 'menu/alignment_image.dart';
import 'menu/size_image.dart';

class ImageWrapper extends StatelessWidget {
  final bool isReadOnly;
  final QuillController controller;
  final Image image;

  const ImageWrapper({
    Key? key,
    required this.controller,
    required this.image,
    required this.isReadOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isReadOnly) {
      return image;
    } else {
      return GestureDetector(
        onLongPress: () {
          FocusScope.of(context).unfocus();
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              children: [
                MenuPopupSizeImageClassification(
                    controller: controller, image: image),
                MenuPopupAlignmentImage(controller: controller, image: image),
                RemoveOption(controller: controller),
              ],
            ),
          );
        },
        child: image,
      );
    }
  }
}
