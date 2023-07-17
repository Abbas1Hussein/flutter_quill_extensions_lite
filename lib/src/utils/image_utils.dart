import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:image_picker/image_picker.dart';

import '../embeds/view/dialogs/media_pick_select.dart';
import 'enum.dart';

class ImageUtils {
  /// chose type MediaPickSetting get picture from [link] or [gallery]
  static Future<MediaPickSetting?> selectMediaPickView(
    BuildContext context,
  ) {
    return showDialog<MediaPickSetting>(
      context: context,
      builder: (ctx) => const MediaPickSelect(),
    );
  }

  /// For image picking logic
  static Future<void> handleImageButtonTap(
    BuildContext context,
    QuillController controller,
    ImageSource imageSource,
  ) async {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    String? imageUrl = await _pickImage(imageSource);

    if (imageUrl != null) {
      controller.replaceText(index, length, BlockEmbed.image(imageUrl), null);
    }
  }

  static Future<String?> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return null;

    return pickedFile.path;
  }
}
