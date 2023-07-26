import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../embeds/view/dialogs/remove.dart';
import 'index.dart';

/// A utility class providing methods for handling image attributes and embedding images.
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

  /// Generates an [Image] widget based on the provided [imageUrl], [width], [height], and [alignment].
  Image imageByUrl(
    String imageUrl, [
    ImageAttributeModel? imageAttributeModel,
  ]) {
    final width = imageAttributeModel?.width.toDouble();
    final height = imageAttributeModel?.height.toDouble();
    final alignment =
        imageAttributeModel?.alignment.alignmentGeometry ?? Alignment.center;
    final boxFit = imageAttributeModel?.boxFit;
    if (ValidatorUtils.isImageBase64(imageUrl)) {
      return Image.memory(
        base64.decode(imageUrl),
        width: width,
        height: height,
        alignment: alignment,
        fit: boxFit,
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        alignment: alignment,
        fit: boxFit,
      );
    }
    return Image.file(
      File(imageUrl),
      width: width,
      height: height,
      alignment: alignment,
      fit: boxFit,
    );
  }

  /// Updates the image attributes of the currently selected image in the [controller].
  void updateImageAttribute({
    required ImageAttributeModel imageAttributeModel,
  }) {
    _quillControllerUtils.controller.document.format(
      _quillControllerUtils.offset,
      1,
      imageAttributeModel.toStyleAttribute(),
    );
  }

  /// Parses the image attributes from the provided [s] string and returns an [ImageAttributeModel].
  ImageAttributeModel? fetchImageAttributeByString(String s) {
    Map<String, String> atr = parseKeyValuePairs(s, {
      'width',
      'height',
      'alignment',
      'boxFit',
    });
    if (atr.isEmpty) return null;

    return ImageAttributeModel.fromJson(atr);
  }

  /// Fetches the image attributes of the currently selected image in the [controller].
  ImageAttributeModel? fetchImageAttributesByOffset() {
    return fetchImageAttributeByString(getImageStyleString());
  }
}

/// Model class representing image attributes like width, height, and alignment.
class ImageAttributeModel {
  final int width;
  final int height;
  final AlignmentImage alignment;
  final BoxFit boxFit;

  ImageAttributeModel({
    required this.width,
    required this.height,
    required this.alignment,
    required this.boxFit,
  });

  /// Creates an [ImageAttributeModel] from a JSON map.
  factory ImageAttributeModel.fromJson(Map<String, dynamic> json) {
    return ImageAttributeModel(
      height: int.parse(json['height']),
      width: int.parse(json['width']),
      alignment: AlignmentImageEx.getAlignment(json['alignment']),
      boxFit: BoxFit.values.firstWhere(
        (element) => element.name.contains(json['boxFit']),
      ),
    );
  }

  /// Converts the [ImageAttributeModel] to a [StyleAttribute] object for formatting in the editor.
  StyleAttribute toStyleAttribute() {
    return StyleAttribute(
      "width: $width; height: $height; alignment: ${alignment.name}; boxFit: ${boxFit.name};",
    );
  }
}

/// class representing options dialog that controller in image like
/// * ---> [SizeClassification], [AlignmentImage], [BoxFit], [RemoveOption].
class OptionsImage {
  final Widget sizeClassification;
  final Widget alignment;
  final Widget boxFit;
  final Widget remove;

  OptionsImage({
    required this.sizeClassification,
    required this.alignment,
    required this.boxFit,
    required this.remove,
  });
}
