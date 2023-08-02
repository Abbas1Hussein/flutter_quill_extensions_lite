/// This library provides extensions and custom components to enhance the functionality of `flutter_quill`.
library flutter_quill_extensions_lite;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'src/embeds/builders/builders.dart';
import 'src/toolbar/box_button.dart';
import 'src/toolbar/toolbar.dart';
import 'src/utils/utils.dart';

export 'src/utils/utils.dart' hide ImageUtils, ValidatorUtils;

/// A collection of utility methods and builders for custom embeds and toolbar buttons.
class FlutterQuillEmbeds {
  /// Returns a list of embed builders to provide support for custom embeds.
  ///
  /// Parameters:
  /// - [boxBuilder]: used to customize the box view.
  /// - [imageBuilder]: used to customize the image view.
  /// - [tableBuilder]: used to customize the table view.
  /// - [dividerBuilder]: used to customize the dividerBuilder view.
  /// - [defaultSizes]: used to customize the default sizes for widgets support.
  static List<EmbedBuilder> builders({
    BoxBuilder? boxBuilder,
    ImageBuilder? imageBuilder,
    TableBuilder? tableBuilder,
    DividerBuilder? dividerBuilder,
    DefaultSizes? defaultSizes,
  }) {
    if (defaultSizes != null) {
      final instance = DefaultSizes.instance;
      instance.updateSmall(defaultSizes.small);
      instance.updateMedium(defaultSizes.medium);
      instance.updateLarge(defaultSizes.large);
    }
    return [
      BoxEmbedBuilder(boxBuilder),
      ImageEmbedBuilder(imageBuilder),
      TableEmbedBuilder(tableBuilder),
      DividerEmbedBuilder(dividerBuilder),
    ];
  }

  /// Returns a list of toolbar button builders to add custom buttons to the Quill editor toolbar.
  ///
  /// Parameters:
  /// - [tooltips]: An optional parameter that allows you to customize tooltips for the buttons.
  /// - [buttons]: An optional parameter that allows you to specify which buttons to display.
  ///
  /// - [useBase64]: An optional parameter that specifies whether to encode the data in base64 format when exporting.
  ///   Set it to 'true' to enable base64 encoding and if it is 'false', the data will be exported as a List of JSON.
  ///
  /// - [mediaPickSettingSelector]: An optional parameter that allows you to customize media pick when clicking the image button.
  /// - [dataOperationSettingSelector]: An optional parameter that allows you to customize data operation when clicking the export/restore button.
  static List<EmbedButtonBuilder> buttons({
    Tooltips? tooltips,
    Buttons? buttons,
    bool useBase64 = true,
    MediaPickSetting? mediaPickSettingSelector,
    DataOperationSetting? dataOperationSettingSelector,
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
                : dataOperationSettingSelector,
            tooltip: tooltips?.dividerButtonTooltip,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
            useBase64: useBase64,
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
        },
      if (buttons == null || buttons.showBoxButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) {
          return BoxToolbarButton(
            tooltip: tooltips?.boxButtonTooltip,
            icon: Icons.rectangle_rounded,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
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
  String? tableButtonTooltip;
  String? boxButtonTooltip;

  Tooltips({
    this.dividerButtonTooltip,
    this.imageButtonTooltip,
    this.dataOperationButtonTooltip,
    this.tableButtonTooltip,
    this.boxButtonTooltip,
  });
}

/// A class to specify which buttons to display in the Quill editor toolbar.
class Buttons {
  bool showImageButton;
  bool showDividerButton;
  bool showDataOperationButton;
  bool showTableButton;
  bool showBoxButton;

  Buttons({
    this.showImageButton = true,
    this.showDividerButton = true,
    this.showDataOperationButton = true,
    this.showTableButton = true,
    this.showBoxButton = true,
  });
}
