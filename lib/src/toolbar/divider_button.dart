import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../flutter_quill_extensions_lite.dart';
import '../embeds/custom/divider.dart';
import '../utils/quill_controller_utils.dart';

/// A button widget for adding line to the Quill editor toolbar.
class DividerToolbarButton extends StatelessWidget {
  const DividerToolbarButton({
    required this.icon,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final QuillController controller;
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
      tooltip: tooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () {
        controller.utils.addValue(CustomDividerEmbeddable());
      },
    );
  }
}
