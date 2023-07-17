library flutter_quill_extensions_lite;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'embeds/builders/image.dart';
import 'embeds/builders/image_web.dart';
import 'toolbar/image_button.dart';
import 'utils/types.dart';

export 'toolbar/image_button.dart';
export 'toolbar/image_utils.dart';
export 'utils/types.dart';
export 'utils/validator.dart';

class FlutterQuillEmbeds {
  static List<EmbedBuilder> builders() => [ImageEmbedBuilder()];

  static List<EmbedBuilder> webBuilders() => [ImageEmbedBuilderWeb()];

  static List<EmbedButtonBuilder> buttons({
    bool showImageButton = true,
    String? imageButtonTooltip,
    OnImagePickCallback? onImagePickCallback,
    MediaPickSettingSelector? mediaPickSettingSelector,
  }) =>
      [
        if (showImageButton)
          (controller, toolbarIconSize, iconTheme, dialogTheme) {
            return ImageButton(
              icon: Icons.image,
              iconSize: toolbarIconSize,
              tooltip: imageButtonTooltip,
              controller: controller,
              onImagePickCallback: onImagePickCallback,
              mediaPickSettingSelector: mediaPickSettingSelector,
              iconTheme: iconTheme,
              dialogTheme: dialogTheme,
            );
          },
      ];
}
