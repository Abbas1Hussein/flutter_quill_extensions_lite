import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/translations.dart';

import '../../../utils/image_utils.dart';
import 'simple.dart';

class CopyOption extends StatelessWidget {
  final QuillController controller;

  const CopyOption({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogItem(
      icon: Icons.copy_all_outlined,
      color: Colors.cyanAccent,
      text: 'Copy'.i18n,
      onPressed: () {
        final imageNode = getEmbedNode(
          controller,
          controller.selection.start,
        ).value;
        final imageUrl = imageNode.value.data;
        controller.copiedImageUrl = ImageUrl(
          imageUrl,
          ImageUtils.getImageStyleString(controller),
        );
        Navigator.pop(context);
      },
    );
  }
}
