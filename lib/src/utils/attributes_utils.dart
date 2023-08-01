import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'utils.dart';

/// A utility class providing getter methods to access various attributes of the editor content.
/// This class is helpful for retrieving information about the text attributes.
class AttributesUtils {
  final Map<String, Attribute<dynamic>> _attributes;

  AttributesUtils(this._attributes);

  /// Returns the background color of the text.
  Color? get backgroundColor => _getHexColor('background');

  /// Returns the text color.
  Color? get color => _getHexColor('color');

  /// Returns whether the text is in bold format.
  bool get isBold => _validate('bold');

  /// Returns whether the text is in italic format.
  bool get isItalic => _validate('italic');

  /// Returns whether the text has a strike-through style.
  bool get isStrike => _validate('strike');

  /// Returns whether the text is underlined.
  bool get isUnderline => _validate('underline');

  /// Get the header level.
  ///
  /// Returns a `Header` or `null` if the attribute is not found.
  Header? get header {
    final String? value = _attributes['header']?.value;

    if (value != null) return null;

    return Header.values.firstWhere((element) => element.name.contains(value!));
  }

  /// Get the text size.
  ///
  /// Returns a `Sizes` or `null` if the attribute is not found.
  Sizes? get sizes {
    final String? value = _attributes['size']?.value;

    if (value != null) return null;

    return Sizes.values.firstWhere((element) => element.name.contains(value!));
  }

  /// Get the hex color from the attribute.
  ///
  /// Returns a `Color` or `null` if the attribute is not found.
  Color? _getHexColor(String value) {
    final color = _attributes['color']?.value;
    if (color != null) {
      return ColorUtils.hexToColor(color);
    }
    return null;
  }

  /// Validates the presence of certain styles (bold, italic, strike, underline).
  bool _validate(String value) {
    final bool? isEnable = _attributes[value]?.value;
    if (isEnable != null && isEnable) {
      return true;
    }
    return false;
  }
}

/// different sizes for the text.
enum Sizes { small, large, huge }

/// different header styles for the text.
enum Header { h1, h2, h3 }
