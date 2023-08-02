import 'package:flutter/material.dart';

/// Enumeration representing the alignment options for an widget.
enum AlignmentCLR { center, right, left }

/// Extension on [AlignmentCLR] to provide additional functionality for working with widget alignments.
extension AlignmentImageEx on AlignmentCLR {
  /// Returns the name of the alignment as a string.
  String get name {
    switch (this) {
      case AlignmentCLR.center:
        return 'center';
      case AlignmentCLR.left:
        return 'left';
      case AlignmentCLR.right:
        return 'right';
    }
  }

  /// Gets the [AlignmentCLR] corresponding to the given [alignment] string.
  /// Returns the appropriate alignment value or [AlignmentCLR.center] if no match is found.
  static AlignmentCLR getAlignment(String alignment) {
    return AlignmentCLR.values.firstWhere(
      (element) => element.name.contains(alignment),
    );
  }

  /// Returns the [AlignmentGeometry] corresponding to the alignment option.
  AlignmentGeometry get alignmentGeometry {
    switch (this) {
      case AlignmentCLR.center:
        return Alignment.center;
      case AlignmentCLR.left:
        return Alignment.centerLeft;
      case AlignmentCLR.right:
        return Alignment.centerRight;
    }
  }
}
