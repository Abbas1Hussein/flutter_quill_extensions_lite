import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'image_utils.dart';

class QuillControllerUtils {
  final QuillController controller;

  static QuillControllerUtils? _instance;

  factory QuillControllerUtils._getInstance(QuillController controller) {
    _instance ??= QuillControllerUtils._(controller);
    return _instance!;
  }

  QuillControllerUtils._(this.controller);

  int get offset => getEmbedNode(controller, controller.selection.start).offset;

  int get index => controller.selection.baseOffset;

  int get length => controller.selection.extentOffset - index;

  void removeValue() {
    controller.replaceText(offset, 1, '', TextSelection.collapsed(offset: offset));
  }

  void addValue(Object value, [Attribute<dynamic>? attribute]) {
    controller.replaceText(index, length, value, null);

    // add attribute
    if (attribute != null) {
      controller.document.format(offset, 1, attribute);
    }
  }

  ImageUtils get imageUtils => ImageUtils(this);
}

extension QuillControllerUtilsExtension on QuillController {
  QuillControllerUtils get utils => QuillControllerUtils._getInstance(this);
}
