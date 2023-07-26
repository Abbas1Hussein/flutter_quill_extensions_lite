import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../utils/index.dart';

class Copy extends StatelessWidget {
  const Copy({
    super.key,
    required this.quillControllerUtils,
    required this.icon,
    required this.iconSize,
    this.fillColor,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
  });

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final QuillControllerUtils quillControllerUtils;
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
      onPressed: quillControllerUtils.copy,
    );
  }
}
