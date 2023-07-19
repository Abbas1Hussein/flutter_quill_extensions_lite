import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../flutter_quill_extensions_lite.dart';
import '../embeds/view/dialogs/media_pick_select.dart';

class ImageUtils {
  ImageUtils._();

  /// chose type MediaPickSetting get picture from [link] or [gallery]
  static Future<MediaPickSetting?> selectMediaPickView(
    BuildContext context,
  ) {
    return showDialog<MediaPickSetting>(
      context: context,
      builder: (ctx) => const MediaPickSelect(),
    );
  }

  /// A list of supported image file extensions.
  static const List<String> imageFileSupported = [
    '.jpeg',
    '.png',
    '.jpg',
    '.gif',
    '.webp',
    '.tif',
    '.heic'
  ];

  /// Retrieves the style string of the currently selected image in the [controller].
  static String getImageStyleString(QuillController controller) {
    final String? s = controller
        .getAllSelectionStyles()
        .firstWhere((s) => s.attributes.containsKey(Attribute.style.key),
            orElse: Style.new)
        .attributes[Attribute.style.key]
        ?.value;
    return s ?? '';
  }

  /// Generates an Image widget based on the provided [imageUrl], [width], [height], and [alignment].
  static Image imageByUrl(
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
        fit: BoxFit.cover,
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        alignment: alignment,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(imageUrl),
      width: width,
      height: height,
      alignment: alignment,
      fit: BoxFit.cover,
    );
  }

  /// Standardizes the provided image [url].
  static String standardizeImageUrl(String url) {
    if (url.contains('base64')) {
      return url.split(',')[1];
    }
    return url;
  }

  /// Appends the file extension to the provided image [url] if necessary.
  static String appendFileExtensionToImageUrl(String url) {
    final endsWithImageFileExtension = imageFileSupported.firstWhere(
      (s) => url.toLowerCase().endsWith(s),
      orElse: () => '',
    );
    if (endsWithImageFileExtension.isNotEmpty) {
      return url;
    }
    return url;
  }
}
