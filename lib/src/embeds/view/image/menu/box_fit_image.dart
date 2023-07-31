import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../../utils/utils.dart';
import '../../dialogs/simple.dart';

class BoxFitImage extends StatefulWidget {
  final QuillController controller;
  final Image image;

  const BoxFitImage({
    super.key,
    required this.controller,
    required this.image,
  });

  @override
  State<BoxFitImage> createState() => _BoxFitImageState();
}

class _BoxFitImageState extends State<BoxFitImage> {
  late QuillControllerUtils quillControllerUtils;
  late BoxFit boxFit;

  @override
  void initState() {
    super.initState();
    quillControllerUtils = widget.controller.utils;
    final attributes =
        quillControllerUtils.imageUtils.fetchImageAttributesByOffset();

    if (attributes != null) {
      boxFit = attributes.boxFit;
    } else {
      boxFit = BoxFit.cover;
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
        icon: Icons.fit_screen_rounded,
        color: Colors.red.shade200,
        text: 'boxFit',
        onPressed: () {},
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildMenuPopup() {
    return BoxFit.values
        .map(
          (element) => PopupMenuItem(
            child: Card(
              color: boxFit == element ? Colors.cyan : Colors.transparent,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child:
                    SizedBox(width: double.infinity, child: Text(element.name)),
              ),
            ),
            onTap: () {
              _onTapHandler(element);
              setState(() => boxFit = element);
            },
          ),
        )
        .toList();
  }

  void _onTapHandler(BoxFit element) {
    quillControllerUtils.controller.moveCursorToPosition(quillControllerUtils.offset);
    final attribute = quillControllerUtils.imageUtils.fetchImageAttributesByOffset();

    quillControllerUtils.imageUtils.updateImageAttribute(
      imageAttributeModel: ImageAttributeModel(
        width: attribute!.width,
        height: attribute.height,
        alignment: attribute.alignment,
        boxFit: element,
      ),
    );
  }
}
