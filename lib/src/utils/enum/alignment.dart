import 'package:flutter/material.dart';

enum AlignmentImage { center, right, left }

extension AlignmentImageEx on AlignmentImage {
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

  static AlignmentImage getAlignment(String alignment) {
    return AlignmentImage.values.firstWhere(
          (element) => element.name.contains(alignment),
    );
  }

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
