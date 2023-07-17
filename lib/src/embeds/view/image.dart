import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../utils/validator.dart';

const List<String> imageFileSupported = [
  '.jpeg',
  '.png',
  '.jpg',
  '.gif',
  '.webp',
  '.tif',
  '.heic'
];

String getImageStyleString(QuillController controller) {
  final String? s = controller
      .getAllSelectionStyles()
      .firstWhere((s) => s.attributes.containsKey(Attribute.style.key),
          orElse: Style.new)
      .attributes[Attribute.style.key]
      ?.value;
  return s ?? '';
}

Image imageByUrl(
  String imageUrl, {
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
}) {
  if (Validator.isImageBase64(imageUrl)) {
    return Image.memory(
      base64.decode(imageUrl),
      width: width,
      height: height,
      alignment: alignment,
    );
  }

  if (imageUrl.startsWith('http')) {
    return Image.network(imageUrl,
        width: width, height: height, alignment: alignment);
  }
  return Image.file(io.File(imageUrl),
      width: width, height: height, alignment: alignment);
}

String standardizeImageUrl(String url) {
  if (url.contains('base64')) {
    return url.split(',')[1];
  }
  return url;
}

String appendFileExtensionToImageUrl(String url) {
  final endsWithImageFileExtension = imageFileSupported.firstWhere(
    (s) => url.toLowerCase().endsWith(s),
    orElse: () => '',
  );
  if (endsWithImageFileExtension.isNotEmpty) {
    return url;
  }
  return url;
}
