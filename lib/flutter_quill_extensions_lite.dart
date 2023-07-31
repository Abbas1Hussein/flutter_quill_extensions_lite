/// This library provides extensions and custom components to enhance the functionality of `flutter_quill`.
library flutter_quill_extensions_lite;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'src/embeds/builders/builders.dart';
import 'src/toolbar/toolbar.dart';
import 'src/utils/utils.dart';

export 'src/utils/utils.dart' hide ImageUtils, ValidatorUtils;

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
      TableEmbedBuilder(),
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
      if (buttons == null || buttons.showDataOperationButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return DataOperationToolbarButton(
            dataOperationSetting: (isMobile() || kIsWeb)
                ? DataOperationSetting.restore
                : dataOperationSetting,
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
      if (buttons == null || buttons.showTableButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return TableToolbarButton(
            tooltip: tooltips?.tableButtonTooltip,
            icon: Icons.table_view_rounded,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          );
        }
    ];
  }
}

/// A class to customize tooltips for the buttons in the Quill editor toolbar.
class Tooltips {
  String? imageButtonTooltip;
  String? dividerButtonTooltip;
  String? dataOperationButtonTooltip;
  String? tableButtonTooltip;

  Tooltips({
    this.dividerButtonTooltip,
    this.imageButtonTooltip,
    this.dataOperationButtonTooltip,
    this.tableButtonTooltip,
  });
}

/// A class to specify which buttons to display in the Quill editor toolbar.
class Buttons {
  bool showImageButton;
  bool showDividerButton;
  bool showDataOperationButton;
  bool showTableButton;

  Buttons({
    this.showImageButton = true,
    this.showDividerButton = true,
    this.showDataOperationButton = true,
    this.showTableButton = true,
  });
}
