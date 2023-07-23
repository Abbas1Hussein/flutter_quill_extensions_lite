import 'package:flutter/material.dart';

/// Enumeration representing the alignment options for an image.
enum AlignmentImage { center, right, left }

/// Extension on [AlignmentImage] to provide additional functionality for working with image alignments.
extension AlignmentImageEx on AlignmentImage {
  /// Returns the name of the alignment as a string.
  String get name {
    switch (this) {
      case AlignmentImage.center:
        return 'center';
      case AlignmentImage.left:
        return 'left';
      case AlignmentImage.right:
        return 'right';
    }
  }

  /// Gets the [AlignmentImage] corresponding to the given [alignment] string.
  /// Returns the appropriate alignment value or [AlignmentImage.center] if no match is found.
  static AlignmentImage getAlignment(String alignment) {
    return AlignmentImage.values.firstWhere(
      (element) => element.name.contains(alignment),
    );
  }

  /// Returns the [AlignmentGeometry] corresponding to the alignment option.
  AlignmentGeometry get alignmentGeometry {
    switch (this) {
      case AlignmentImage.center:
        return Alignment.center;
      case AlignmentImage.left:
        return Alignment.centerLeft;
      case AlignmentImage.right:
        return Alignment.centerRight;
    }
  }
}
