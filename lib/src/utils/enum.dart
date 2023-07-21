import 'package:flutter/material.dart';

const _kSmallSize = Size(200, 200);
const _kMediumSize = Size(800, 400);
const _kLargeSize = Size(1200, 600);

enum SizeClassification { small, medium, large, originalSize }


extension SizeClassificationExtension on SizeClassification {
  Size getSize() {
    switch (this) {
      case SizeClassification.small:
        return _kSmallSize;
      case SizeClassification.medium:
        return _kMediumSize;
      case SizeClassification.large:
        return _kLargeSize;
      case SizeClassification.originalSize:
        throw 'you can\'t handel originalSize her';
    }
  }

  static SizeClassification getClassification(Size size) {
    final width = size.width;
    final height = size.height;

    if (width == _kSmallSize.width && height == _kSmallSize.height) {
      return SizeClassification.small;
    }
    if (width == _kMediumSize.width && height == _kMediumSize.height) {
      return SizeClassification.medium;
    }
    if (width == _kLargeSize.width && height == _kLargeSize.height) {
      return SizeClassification.large;
    }
    return SizeClassification.originalSize;
  }
}

enum MediaPickSetting { gallery, link }

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
