import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'utils.dart';

/// A utility class providing methods form editor such as backgroundColors and color etc...
class ToolbarUtils {
  final Map<String, Attribute<dynamic>> _attributes;

  ToolbarUtils(this._attributes);

  Color? get backgroundColor {
    final background = _attributes['background']?.value;
    if (background != null) {
      return ColorUtils.hexToColor(background);
    }
    return null;
  }

  Color? get color {
    final background = _attributes['color']?.value;
    if (background != null) {
      return ColorUtils.hexToColor(background);
    }
    return null;
  }

  bool get isBold {
    final bool? isBold = _attributes['bold']?.value;
    if (isBold != null && isBold) {
      return true;
    }
    return false;
  }
}
