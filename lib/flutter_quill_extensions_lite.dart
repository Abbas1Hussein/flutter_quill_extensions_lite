/// This library provides extensions and custom components to enhance the functionality of `flutter_quill`.
library flutter_quill_extensions_lite;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions_lite/src/toolbar/data_operation_button.dart';

import 'src/embeds/builders/divider.dart';
import 'src/embeds/builders/image.dart';
import 'src/toolbar/divider_button.dart';
import 'src/toolbar/image_button.dart';
import 'src/utils/index.dart';

export 'src/toolbar/image_button.dart';
export 'src/utils/index.dart' hide ImageUtils, ValidatorUtils;

/// A collection of utility methods and builders for custom embeds and toolbar buttons.
class FlutterQuillEmbeds {
  /// Returns a list of embed builders to provide support for custom embeds.
  ///
  /// Parameters:
  /// - [imageBuilder]: An optional parameter that allows you to customize the image view.
  /// - [defaultSizes]: An optional parameter that allows you to customize the default sizes for images.
  static List<EmbedBuilder> builders({
    ImageBuilder? imageBuilder,
    DefaultSizes? defaultSizes,
  }) {
    if (defaultSizes != null) {
      final instance = DefaultSizes.instance;
      instance.updateSmall(defaultSizes.small);
      instance.updateMedium(defaultSizes.medium);
      instance.updateLarge(defaultSizes.large);
    }
    return [
      ImageEmbedBuilder(imageBuilder),
      DividerEmbedBuilder(),
    ];
  }

  /// Returns a list of toolbar button builders to add custom buttons to the Quill editor toolbar.
  ///
  /// Parameters:
  /// - [tooltips]: An optional parameter that allows you to customize tooltips for the buttons.
  /// - [buttons]: An optional parameter that allows you to specify which buttons to display.
  /// - [mediaPickSettingSelector]: An optional parameter that allows you to customize media pick when clicking the image button.
  static List<EmbedButtonBuilder> buttons({
    Tooltips? tooltips,
    Buttons? buttons,
    bool useBase64 = true,
    MediaPickSetting? mediaPickSettingSelector,
    DataOperationSetting? dataOperationSetting,
  }) {
    return [
      if (buttons == null || buttons.showImageButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return ImageToolbarButton(
            icon: Icons.image,
            iconSize: toolbarIconSize,
            tooltip: tooltips?.imageButtonTooltip,
            controller: controller,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          );
        },
      if (buttons == null || buttons.showDataOperationButtonTooltip)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return DataOperationToolbarButton(
            dataOperationSetting: dataOperationSetting,
            tooltip: tooltips?.dividerButtonTooltip,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
            useBase64: useBase64,
          );
        },
      if (buttons == null || buttons.showDividerButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return DividerToolbarButton(
            tooltip: tooltips?.dividerButtonTooltip,
            icon: Icons.horizontal_rule_rounded,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          );
        },
    ];
  }
}

/// A class to customize tooltips for the buttons in the Quill editor toolbar.
class Tooltips {
  String? imageButtonTooltip;
  String? dividerButtonTooltip;
  String? dataOperationButtonTooltip;

  Tooltips({
    this.dividerButtonTooltip,
    this.imageButtonTooltip,
    this.dataOperationButtonTooltip,
  });
}

/// A class to specify which buttons to display in the Quill editor toolbar.
class Buttons {
  bool showImageButton;
  bool showDividerButton;
  bool showDataOperationButtonTooltip;

  Buttons({
    this.showImageButton = true,
    this.showDividerButton = true,
    this.showDataOperationButtonTooltip = true,
  });
}
