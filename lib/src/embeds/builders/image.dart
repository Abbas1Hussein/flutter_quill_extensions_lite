import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions_lite/src/embeds/custom/image.dart';

import '../view/image/image.dart';

/// This class is an implementation of the [EmbedBuilder] interface specific
/// to rendering image embeds in the Quill editor.
class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => CustomImageEmbeddable.imageType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide image EmbedBuilder for Web');

    return ImageWrapper(controller: controller, image: node.value.data);
  }
}
