import 'dart:convert';
import 'dart:io' show File;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../embeds/view/dialogs/data_operation_select.dart';
import '../utils/utils.dart';

/// A toolbar button widget that handles data operations such as export and restore.
class DataOperationToolbarButton extends StatelessWidget {
  const DataOperationToolbarButton({
    required this.controller,
    required this.useBase64,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.dataOperationSetting,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final bool useBase64;
  final double iconSize;
  final Color? fillColor;
  final QuillController controller;
  final DataOperationSetting? dataOperationSetting;
  final QuillIconTheme? iconTheme;
  final QuillDialogTheme? dialogTheme;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor =
        iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);

    return QuillIconButton(
      icon: Icon(icon, size: iconSize, color: iconColor),
      tooltip: tooltip ?? defaultTooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => _onPressedHandler(context),
    );
  }

  // Get Icon based on the dataOperationSetting
  IconData get icon {
    switch (dataOperationSetting) {
      case (DataOperationSetting.export):
        return Icons.upload_file_rounded;
      case (DataOperationSetting.restore):
        return Icons.restore_page_rounded;
      default:
        return Icons.file_open_rounded;
    }
  }

  // Get Default Tooltip based on the dataOperationSetting
  String get defaultTooltip {
    switch (dataOperationSetting) {
      case (DataOperationSetting.export):
        return 'export';
      case (DataOperationSetting.restore):
        return 'restore';
      default:
        return 'export/restore';
    }
  }

  // Handle onPressed event
  Future<void> _onPressedHandler(BuildContext context) async {
    if (dataOperationSetting == null) {
      // If the dataOperationSetting is not provided, show the DataOperationSelect dialog
      final source = await const DataOperationSelect().show(context);
      if (source != null) {
        // If the user selects an option from the dialog, perform the corresponding data operation
        if (source == DataOperationSetting.export) {
          handleExportDataOperation();
        } else {
          handleRestoreDataOperation();
        }
      }
    } else if (dataOperationSetting == DataOperationSetting.export) {
      handleExportDataOperation();
    } else {
      handleRestoreDataOperation();
    }
  }

// Export Data logic
  Future<void> handleExportDataOperation() async {
    try {
      // Get the JSON data from the controller
      final data = useBase64
          ? base64Encode(utf8.encode(controller.utils.data))
          : controller.utils.data;

      // Prompt the user to choose the file location and name
      final result = await FilePicker.platform.saveFile(
        allowedExtensions: ['txt'],
        fileName: 'file_name.txt',
        type: FileType.custom,
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsString(data);
      }
    } catch (e) {
      throw Exception('Error exporting data: $e');
    }
  }

  // Restore Data logic
  Future<void> handleRestoreDataOperation() async {
    try {
      // Prompt the user to choose the file location and name
      final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['txt'],
        type: FileType.custom,
      );

      if (result != null) {
        final file = File(result.files.single.path!);

        final data = await file.readAsString();

        if (ValidatorUtils.isBase64(data)) {
          controller.utils.insert(jsonDecode(utf8.decode(base64Decode(data))));
        } else {
          controller.utils.insert(jsonDecode(data));
        }
      }
    } catch (e) {
      throw Exception('Error restoring data: $e');
    }
  }
}
