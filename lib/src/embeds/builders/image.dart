import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart' as base;
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../utils/validator.dart';
import '../view/dialogs/copy.dart';
import '../view/dialogs/remove.dart';
import '../view/dialogs/resize.dart';
import '../view/image.dart';

class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide image EmbedBuilder for Web');

    var image;
    final imageUrl = standardizeImageUrl(node.value.data);

    OptionalSize? imageSize;
    final style = node.style.attributes['style'];
    if (base.isMobile() && style != null) {
      final _attrs = base.parseKeyValuePairs(style.value.toString(), {
        Attribute.mobileWidth,
        Attribute.mobileHeight,
        Attribute.mobileMargin,
        Attribute.mobileAlignment
      });
      if (_attrs.isNotEmpty) {
        assert(
          _attrs[Attribute.mobileWidth] != null && _attrs[Attribute.mobileHeight] != null,
          'mobileWidth and mobileHeight must be specified',
        );
        final w = double.parse(_attrs[Attribute.mobileWidth]!);
        final h = double.parse(_attrs[Attribute.mobileHeight]!);

        imageSize = OptionalSize(w, h);

        final m = _attrs[Attribute.mobileMargin] == null ? 0.0 : double.parse(_attrs[Attribute.mobileMargin]!);
        final a = base.getAlignment(_attrs[Attribute.mobileAlignment]);
        image = Padding(
          padding: EdgeInsets.all(m),
          child: imageByUrl(imageUrl, width: w, height: h, alignment: a),
        );
      }
    }

    if (imageSize == null) {
      image = imageByUrl(imageUrl);
      imageSize = OptionalSize((image as Image).width, image.height);
    }

    /// mobile
    if (!readOnly && base.isMobile()) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: SimpleDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  children: [
                    ResizeOption(
                      controller: controller,
                      width: imageSize?.width,
                      height: imageSize?.height,
                    ),
                    CopyOption(controller: controller),
                    RemoveOption(controller: controller)
                  ],
                ),
              );
            },
          );
        },
        child: image,
      );
    }

    /// desktop
    if (!readOnly || !base.isMobile() || Validator.isImageBase64(imageUrl)) {
      return image;
    }

    return image;
  }
}
