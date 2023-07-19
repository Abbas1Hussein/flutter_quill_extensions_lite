import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';

import '../../../../flutter_quill_extensions_lite.dart';
import '../../../utils/quill_controller_utils.dart';
import '../dialogs/simple.dart';

class SizeBottomSheet extends StatefulWidget {
  final QuillController controller;

  final String imageUrl;
  final Image image;

  const SizeBottomSheet({
    super.key,
    required this.controller,
    required this.imageUrl,
    required this.image,
  });

  @override
  State<SizeBottomSheet> createState() => _SizeBottomSheetState();
}

class _SizeBottomSheetState extends State<SizeBottomSheet> {
  late SizeClassification sizeClassification;
  late int currentIndex;

  late double height;

  late double width;

  @override
  void initState() {
    super.initState();
    imageResolve();
    sizeClassification = SizeClassification.originalSize;
    currentIndex = 0;
  }

  void imageResolve() {
    final imageUtils = ImageUtils.imageByUrl(widget.imageUrl);
    imageUtils.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          height = info.image.height.toDouble();
          width = info.image.width.toDouble();
        },
      ),
    );
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
    return List.generate(
      SizeClassification.values.length,
      (index) => PopupMenuItem(
        child: Card(
          color: currentIndex == index ? Colors.cyan : Colors.transparent,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(SizeClassification.values[index].name),
            ),
          ),
        ),
        onTap: () => onTapHandler(index),
      ),
    );
  }

  void onTapHandler(int index) {
    QuillControllerUtils.removeValueByOffset(widget.controller);
    QuillControllerUtils.addValueByOffset(widget.controller, BlockEmbed.image(widget.imageUrl));

    setState(() {
      sizeClassification = SizeClassification.values[index];
      currentIndex = index;
    });

    if (sizeClassification == SizeClassification.originalSize) {
      QuillControllerUtils.updateImageAttribute(
        controller: widget.controller,
        width: width,
        height: height,
        margin: 8.0,
        alignment: Alignment.center,
      );
    } else {
      final size = sizeClassification.getSizeClassification(context);
      QuillControllerUtils.updateImageAttribute(
        controller: widget.controller,
        width: size.width,
        height: size.height,
        margin: 8.0,
        alignment: Alignment.center,
      );
    }
  }
}
