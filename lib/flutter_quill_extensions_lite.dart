library flutter_quill_extensions_lite;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'src/embeds/builders/divider.dart';
import 'src/embeds/builders/image.dart';
import 'src/embeds/builders/image_web.dart';
import 'src/toolbar/divider_button.dart';
import 'src/toolbar/image_button.dart';
import 'src/utils/index.dart';

export 'src/toolbar/image_button.dart';
export 'src/utils/image_utils.dart';
export 'src/utils/index.dart';

class FlutterQuillEmbeds {
  static List<EmbedBuilder> builders() {
    return [
      ImageEmbedBuilder(),
      DividerEmbedBuilder(),
    ];
  }

  static List<EmbedBuilder> webBuilders() {
    return [
      ImageEmbedBuilderWeb(),
      DividerEmbedBuilder(),
    ];
  }

  static List<EmbedButtonBuilder> buttons({
    required Tooltips tooltips,
    required Buttons buttons,
    MediaPickSetting? mediaPickSettingSelector,
  }) {
    return [
      if (buttons.showImageButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return ImageToolbarButton(
            icon: Icons.image,
            iconSize: toolbarIconSize,
            tooltip: tooltips.imageButtonTooltip,
            controller: controller,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          );
        },
      (controller, toolbarIconSize, iconTheme, dialogTheme) {
        return DividerToolbarButton(
          tooltip: tooltips.dividerButtonTooltip,
          icon: Icons.horizontal_rule_rounded,
          iconSize: toolbarIconSize,
          controller: controller,
          iconTheme: iconTheme,
          dialogTheme: dialogTheme,
        );
      }
    ];
  }
}

class Tooltips {
  String? imageButtonTooltip;
  String? dividerButtonTooltip;

  Tooltips({this.dividerButtonTooltip, this.imageButtonTooltip});
}

class Buttons {
  bool showImageButton;
  bool showDividerButton;

  Buttons({
    this.showImageButton = true,
    this.showDividerButton = true,
  });
}
