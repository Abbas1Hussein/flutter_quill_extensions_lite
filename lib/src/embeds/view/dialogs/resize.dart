import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/translations.dart';

import '../image.dart';
import '../image_resizer.dart';
import 'simple.dart';

class ResizeOption extends StatelessWidget {
  final QuillController controller;

  final double? height;
  final double? width;

  const ResizeOption({
    required this.controller,
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SimpleDialogItem(
      icon: Icons.settings_outlined,
      color: Colors.lightBlueAccent,
      text: 'Resize'.i18n,
      onPressed: () {
        Navigator.pop(context);
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) {
            return ImageResizer(
              onImageResize: (w, h) {
                final res =
                    getEmbedNode(controller, controller.selection.start);
                final attr =
                    replaceStyleString(getImageStyleString(controller), w, h);
                controller
                  ..skipRequestKeyboard = true
                  ..formatText(
                    res.offset,
                    1,
                    StyleAttribute(attr),
                  );
              },
              imageWidth: width,
              imageHeight: height,
              maxWidth: screenSize.width,
              maxHeight: screenSize.height,
            );
          },
        );
      },
    );
  }
}
