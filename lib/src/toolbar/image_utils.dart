import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/enum.dart';

class ImageUtils {
  static Future<MediaPickSetting?> defaultSelectMediaPickSetting(
    BuildContext context,
  ) =>
      showDialog<MediaPickSetting>(
        context: context,
        builder: (ctx) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // get picture from gallery
              TextButton.icon(
                icon: const Icon(Icons.collections, color: Colors.orangeAccent),
                label: Text('Gallery'.i18n),
                onPressed: () => Navigator.pop(ctx, MediaPickSetting.gallery),
              ),
              // get picture from url
              TextButton.icon(
                icon: const Icon(Icons.link, color: Colors.cyanAccent),
                label: Text('Link'.i18n),
                onPressed: () => Navigator.pop(ctx, MediaPickSetting.link),
              )
            ],
          ),
        ),
      );

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
