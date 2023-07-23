import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'index.dart';

class ImageUtils {
  final QuillControllerUtils _quillControllerUtils;

  ImageUtils(this._quillControllerUtils);

  /// Retrieves the style string of the currently selected image in the [controller].
  String getImageStyleString() {
    final String? s = _quillControllerUtils.controller
        .getAllSelectionStyles()
        .firstWhere((s) => s.attributes.containsKey(Attribute.style.key),
            orElse: Style.new)
        .attributes[Attribute.style.key]
        ?.value;
    return s ?? '';
  }

  /// Generates an Image widget based on the provided [imageUrl], [width], [height], and [alignment].
  Image imageByUrl(
    String imageUrl, [
    ImageAttributeModel? imageAttributeModel,
  ]) {
    final width = imageAttributeModel?.width.toDouble();
    final height = imageAttributeModel?.height.toDouble();
    final alignment =
        imageAttributeModel?.alignment.alignmentGeometry ?? Alignment.center;
    if (ValidatorUtils.isImageBase64(imageUrl)) {
      return Image.memory(
        base64.decode(imageUrl),
        width: width,
        height: height,
        alignment: alignment,
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        alignment: alignment,
      );
    }
    return Image.file(
      File(imageUrl),
      width: width,
      height: height,
      alignment: alignment,
    );
  }

  void updateImageAttribute({
    required ImageAttributeModel imageAttributeModel,
  }) {
    _quillControllerUtils.controller.document.format(
      _quillControllerUtils.offset,
      1,
      imageAttributeModel.toStyleAttribute(),
    );
  }

  ImageAttributeModel? fetchImageAttributeByString(String s) {
    Map<String, String> atr = parseKeyValuePairs(s, {
      'width',
      'height',
      'alignment',
    });
    if (atr.isEmpty) return null;

    return ImageAttributeModel.fromJson(atr);
  }

  ImageAttributeModel? fetchImageAttributesByOffset() {
    return fetchImageAttributeByString(getImageStyleString());
  }
}

class ImageAttributeModel {
  final int width;
  final int height;
  final AlignmentImage alignment;

  ImageAttributeModel({
    required this.width,
    required this.height,
    required this.alignment,
  });

  factory ImageAttributeModel.fromJson(Map<String, dynamic> json) {
    return ImageAttributeModel(
      height: int.parse(json['height']),
      width: int.parse(json['width']),
      alignment: AlignmentImageEx.getAlignment(json['alignment']),
    );
  }

  StyleAttribute toStyleAttribute() {
    return StyleAttribute(
      "width: $width; height: $height; alignment: ${alignment.name}",
    );
  }
}
