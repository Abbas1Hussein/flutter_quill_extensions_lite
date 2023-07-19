import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions_lite/src/embeds/view/image/image.dart';

import '../../utils/image_utils.dart';

/// This class is an implementation of the [EmbedBuilder] interface specific to
/// rendering image embeds in the Quill editor. Here's a breakdown of the code:
///
/// The [build] method is overridden to define how the image embed should be rendered.
/// An assertion is made to ensure that the code is not executed on the web platform.
///
/// The image URL is standardized using the standardizeImageUrl function from [ImageUtils].
/// A variable image is declared to hold the image widget.
///
/// An OptionalSize variable imageSize is declared to hold the dimensions of the image.
/// The style attribute is retrieved from the node and checked if it is present and the platform is mobile.
///
/// The image widget is wrapped with a AdaptiveImageView
///
/// * Overall, this class provides the necessary functionality to render and interact with image embeds in the Quill editor.
class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(BuildContext context,
      QuillController controller,
      Embed node,
      bool readOnly,
      bool inline,
      TextStyle textStyle,) {
    assert(!kIsWeb, 'Please provide image EmbedBuilder for Web');

    final imageUrl = ImageUtils.standardizeImageUrl(node.value.data);

    Image image = ImageUtils.imageByUrl(imageUrl);


    if (node.style.attributes.isNotEmpty) {
      final atr =
      parseKeyValuePairs(ImageUtils.getImageStyleString(controller), {
        'width',
        'height',
        'margin',
        'alignment',
      });

      image = ImageUtils.imageByUrl(
        imageUrl,
        width: double.parse(atr['width']!),
        height: double.parse(atr['height']!),
      );
    }

    return AdaptiveImageView(
      controller: controller,
      image: image,
      imageUrl: imageUrl,
    );
  }
}

bool _scheduled = false;

void _resizeImage(VoidCallback callback) {
  if (_scheduled) return;

  _scheduled = true;
  SchedulerBinding.instance.addPostFrameCallback(
        (_) {
      callback();
      _scheduled = false;
    },
  );
}
