import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../embeds/view/dialogs/remove.dart';
import 'utils.dart';

/// A utility class providing methods for handling image attributes and embedding images.
class ImageUtils {
  /// Generates an [Image] widget based on the provided [imageUrl], [width], [height], and [alignmentImageButton].
  static Image imageByUrl(
    String imageUrl, [
    ImageModel? imageAttributeModel,
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
}

/// Model class representing image attributes like width, height, and alignment.
class ImageModel {
  final int width;
  final int height;
  final AlignmentCLR alignment;
  final BoxFit boxFit;

  ImageModel({
    required this.width,
    required this.height,
    required this.alignment,
    required this.boxFit,
  });

  /// Creates an [ImageModel] from a JSON map.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      height: json['height'],
      width: json['width'],
      alignment: AlignmentImageEx.getAlignment(json['alignment']),
      boxFit: BoxFit.values.firstWhere(
        (element) => element.name.contains(json['boxFit']),
      ),
    );
  }

  /// Converts the [ImageModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'alignment': alignment.name,
      'boxFit': boxFit.name
    };
  }

  /// Converts the [ImageModel] to a [StyleAttribute] object for formatting in the editor.
  Attribute toAttribute() => DataAttribute(toJson());
}

/// class representing options dialog that controller in image like
/// * ---> [SizeClassification], [Alignment], [BoxFit], [RemoveOption].
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
