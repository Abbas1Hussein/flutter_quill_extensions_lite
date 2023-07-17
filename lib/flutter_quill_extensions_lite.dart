library flutter_quill_extensions_lite;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'embeds/builders.dart';
import 'embeds/embed_types.dart';
import 'embeds/toolbar/image_button.dart';

export 'embeds/embed_types.dart';
export 'embeds/toolbar/image_button.dart';
export 'embeds/toolbar/image_video_utils.dart';
export 'embeds/utils.dart';

class FlutterQuillEmbeds {
  static List<EmbedBuilder> builders() => [ImageEmbedBuilder()];

  static List<EmbedBuilder> webBuilders() => [ImageEmbedBuilderWeb()];

  static List<EmbedButtonBuilder> buttons({
    bool showImageButton = true,
    String? imageButtonTooltip,
    OnImagePickCallback? onImagePickCallback,
    MediaPickSettingSelector? mediaPickSettingSelector,
    FilePickImpl? filePickImpl,
    WebImagePickImpl? webImagePickImpl,
  }) {
    return [
      if (showImageButton)
            (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return ImageButton(
            icon: Icons.image,
            iconSize: toolbarIconSize,
            tooltip: imageButtonTooltip,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          );
        },
    ];
  }
}
