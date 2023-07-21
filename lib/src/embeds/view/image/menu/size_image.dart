import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:flutter_quill_extensions_lite/src/embeds/custom/image.dart';

import '../../../../../flutter_quill_extensions_lite.dart';
import '../../../../utils/quill_controller_utils.dart';
import '../../dialogs/simple.dart';

class MenuPopupSizeImageClassification extends StatefulWidget {
  final QuillController controller;
  final Image image;

  const MenuPopupSizeImageClassification({
    super.key,
    required this.controller,
    required this.image,
  });

  @override
  State<MenuPopupSizeImageClassification> createState() =>
      _MenuPopupSizeImageClassificationState();
}

class _MenuPopupSizeImageClassificationState
    extends State<MenuPopupSizeImageClassification> {
  late QuillControllerUtils quillControllerUtils;
  late SizeClassification sizeClassification;

  late int width;
  late int height;

  @override
  void initState() {
    super.initState();
    resolveImage();
    quillControllerUtils = widget.controller.utils;
    final attribute = quillControllerUtils.imageUtils.fetchImageAttributesByOffset();
    if (attribute != null) {
      sizeClassification = SizeClassificationExtension.getClassification(
        Size(attribute.width.toDouble(), attribute.height.toDouble()),
      );
    } else {
      sizeClassification = SizeClassification.originalSize;
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
        icon: Icons.photo_size_select_large,
        color: Colors.red.shade200,
        text: 'Resize'.i18n,
        onPressed: () {},
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildMenuPopup() {
    return SizeClassification.values
        .map(
          (element) => PopupMenuItem(
            child: Card(
              color: sizeClassification == element
                  ? Colors.cyan
                  : Colors.transparent,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child:
                    SizedBox(width: double.infinity, child: Text(element.name)),
              ),
            ),
            onTap: () {
              _onTapHandler(element);
              setState(() => sizeClassification = element);
            },
          ),
        )
        .toList();
  }

  void _onTapHandler(SizeClassification element) {
    final oldAttribute =
        quillControllerUtils.imageUtils.fetchImageAttributesByOffset();
    ImageAttributeModel imageAttributeModel;

    if (element == SizeClassification.originalSize) {
      imageAttributeModel = ImageAttributeModel(
        width: width,
        height: height,
        alignment: oldAttribute!.alignment,
      );
    } else {
      final size = element.getSize();
      imageAttributeModel = ImageAttributeModel(
        width: size.width.toInt(),
        height: size.height.toInt(),
        alignment: oldAttribute!.alignment,
      );
    }

    quillControllerUtils.removeValue();
    quillControllerUtils.addValue(
      CustomImageEmbeddable(
        Image(
          image: widget.image.image,
          width: imageAttributeModel.width.toDouble(),
          height: imageAttributeModel.height.toDouble(),
          alignment: imageAttributeModel.alignment.alignmentGeometry,
        ),
      ),
    );

    quillControllerUtils.imageUtils.updateImageAttribute(
      imageAttributeModel: imageAttributeModel,
    );
  }

  void resolveImage() {
    final resolve = widget.image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(
      ImageStreamListener((image, synchronousCall) {
        width = image.image.width;
        height = image.image.height;
      }),
    );
  }
}
