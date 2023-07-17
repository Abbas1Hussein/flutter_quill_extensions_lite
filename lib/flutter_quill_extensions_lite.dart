library flutter_quill_extensions_lite;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'src/embeds/builders/image.dart';
import 'src/embeds/builders/image_web.dart';
import 'src/toolbar/image_button.dart';
import 'src/utils/index.dart';

export 'src/toolbar/image_button.dart';
export 'src/utils/image_utils.dart';
export 'src/utils/index.dart';

class FlutterQuillEmbeds {
  static List<EmbedBuilder> builders() => [ImageEmbedBuilder()];

  static List<EmbedBuilder> webBuilders() => [ImageEmbedBuilderWeb()];

  static List<EmbedButtonBuilder> buttons({
    bool showImageButton = true,
    String? imageButtonTooltip,
    MediaPickSettingSelector? mediaPickSettingSelector,
  }) =>
      [
        if (showImageButton)
          (controller, toolbarIconSize, iconTheme, dialogTheme) {
            return ImageToolbarButton(
              icon: Icons.image,
              iconSize: toolbarIconSize,
              tooltip: imageButtonTooltip,
              controller: controller,
              mediaPickSettingSelector: mediaPickSettingSelector,
              iconTheme: iconTheme,
              dialogTheme: dialogTheme,
            );
          },
      ];
}
