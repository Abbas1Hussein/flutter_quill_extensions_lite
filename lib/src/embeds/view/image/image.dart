import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../flutter_quill_extensions_lite.dart';
import '../dialogs/remove.dart';
import 'menu/alignment_image.dart';
import 'menu/box_fit_image.dart';
import 'menu/size_image.dart';

class ImageWrapperView extends StatelessWidget {
  final String url;

  final ImageBuilder? imageBuilder;

  final Map<String, Attribute<dynamic>> attributes;
  final QuillController controller;
  final bool isReadOnly;

  const ImageWrapperView({
    Key? key,
    required this.url,
    required this.controller,
    required this.isReadOnly,
    required this.attributes,
    required this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageBuilder != null) {
      return imageBuilder!(
        _imageAttributes(),
        OptionsImage(
          sizeClassification: sizeClassification(),
          alignment: alignment(),
          boxFit: boxFit(),
          remove: remove(),
        ),
        isReadOnly,
      );
    } else if (isReadOnly) {
      return _imageAttributes();
    } else {
      return GestureDetector(
        onLongPress: () {
          FocusScope.of(context).unfocus();
          showDialog(
            context: context,
            builder: (context) => _simpleDialog(),
          );
        },
        child: _imageAttributes(),
      );
    }
  }

  Widget sizeClassification() => MenuPopupSizeImageClassification(controller: controller, image: _imageAttributes());

  Widget alignment() => MenuPopupAlignmentImage(controller: controller, image: _imageAttributes());

  Widget boxFit() => BoxFitImage(controller: controller, image: _imageAttributes());

  Widget remove() => RemoveOption(controller: controller);

  Widget _simpleDialog() {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      children: [sizeClassification(), alignment(), boxFit(), remove()],
    );
  }

  Image _imageAttributes() {
    if (attributes.isNotEmpty) {
      final imageAttributes = controller.utils.imageUtils.fetchImageAttributeByString(
        attributes['style']!.value,
      );
      return controller.utils.imageUtils.imageByUrl(url, imageAttributes);
    } else {
      return controller.utils.imageUtils.imageByUrl(url);
    }
  }
}
