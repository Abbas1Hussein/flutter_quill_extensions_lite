import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../../utils/index.dart';
import '../../dialogs/simple.dart';

class MenuPopupAlignmentImage extends StatefulWidget {
  final QuillController controller;
  final Image image;

  const MenuPopupAlignmentImage({
    super.key,
    required this.controller,
    required this.image,
  });

  @override
  State<MenuPopupAlignmentImage> createState() =>
      _MenuPopupAlignmentImageState();
}

class _MenuPopupAlignmentImageState extends State<MenuPopupAlignmentImage> {
  late QuillControllerUtils quillControllerUtils;
  late AlignmentImage alignmentImage;

  @override
  void initState() {
    super.initState();
    quillControllerUtils = widget.controller.utils;
    final attributes = quillControllerUtils.imageUtils.fetchImageAttributesByOffset();

    if (attributes != null) {
      alignmentImage = AlignmentImageEx.getAlignment(attributes.alignment.name);
    } else {
      alignmentImage = AlignmentImage.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final left = details.globalPosition.dx;
        final top = details.globalPosition.dy;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, left, 0),
          items: _buildMenuPopup(),
        );
      },
      child: SimpleDialogItem(
        icon: Icons.format_align_center_rounded,
        color: Colors.red.shade200,
        text: 'alignment',
        onPressed: () {},
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildMenuPopup() {
    return AlignmentImage.values.map(
          (element) => PopupMenuItem(
            child: Card(
              color:
                  alignmentImage == element ? Colors.cyan : Colors.transparent,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child:
                    SizedBox(width: double.infinity, child: Text(element.name)),
              ),
            ),
            onTap: () {
              _onTapHandler(element);
              setState(() => alignmentImage = element);
            },
          ),
        ).toList();
  }

  void _onTapHandler(AlignmentImage element) {
    quillControllerUtils.controller.moveCursorToPosition(quillControllerUtils.offset);
    final attribute = quillControllerUtils.imageUtils.fetchImageAttributesByOffset();

    quillControllerUtils.imageUtils.updateImageAttribute(
      imageAttributeModel: ImageAttributeModel(
        width: attribute!.width,
        height: attribute.height,
        boxFit: attribute.boxFit,
        alignment: element,
      ),
    );
  }
}
