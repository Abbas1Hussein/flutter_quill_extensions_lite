import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../flutter_quill_extensions_lite.dart';
import '../embeds/view/dialogs/media_pick_select.dart';

class QuillControllerUtils {
  QuillControllerUtils._();

  static int offset(QuillController controller) {
    return getEmbedNode(controller, controller.selection.start).offset;
  }

  static void removeValueByOffset(QuillController controller) {
    controller.replaceText(
      offset(controller),
      1,
      '',
      TextSelection.collapsed(offset: offset(controller)),
    );
  }

  static void addValueByOffset(QuillController controller, Object value) {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;
    controller.replaceText(index, length, value, null);
  }

  static void updateImageAttribute({
    required QuillController controller,
    required double width,
    required double height,
    required double margin,
    required Alignment alignment,
  }) {
    controller.document.format(
      offset(controller),
      1,
      imageAttribute(width: width, height: height, alignment: alignment, margin: margin),
    );
  }

  static StyleAttribute imageAttribute({
    required double width,
    required double height,
    required double margin,
    required Alignment alignment,
  }) {
    return StyleAttribute(
      "width: $width; height: $height; margin: $margin; alignment: $alignment",
    );
  }
}
