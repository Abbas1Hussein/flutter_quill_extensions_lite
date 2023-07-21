import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../custom/divider.dart';
import '../view/divider/divider.dart';

class DividerEmbedBuilder extends EmbedBuilder {
  @override
  String get key => CustomDividerEmbeddable.dividerType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return DividerWrapper(attributes: node.style.attributes);
  }
}
