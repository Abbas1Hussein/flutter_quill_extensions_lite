import 'package:flutter/material.dart';

const _kSmallSize = Size(200, 200);
const _kMediumSize = Size(800, 400);
const _kLargeSize = Size(1200, 600);

enum SizeClassification { small, medium, large, originalSize }

extension SizeClassificationExtension on SizeClassification {
  static get defaultSizes => DefaultSizes.instance;

  Size getSize() {
    switch (this) {
      case SizeClassification.small:
        return defaultSizes.small;
      case SizeClassification.medium:
        return defaultSizes.medium;
      case SizeClassification.large:
        return defaultSizes.large;
      case SizeClassification.originalSize:
        throw 'you can\'t handel originalSize her';
    }
  }

  static SizeClassification getClassification(Size size) {
    final width = size.width;
    final height = size.height;

    if (width == defaultSizes.small.width && height == defaultSizes.small.height) {
      return SizeClassification.small;
    }
    if (width == defaultSizes.medium.width && height == defaultSizes.medium.height) {
      return SizeClassification.medium;
    }
    if (width == defaultSizes.large.width && height == defaultSizes.large.height) {
      return SizeClassification.large;
    }
    return SizeClassification.originalSize;
  }
}

class DefaultSizes {
  Size _small;
  Size _medium;
  Size _large;

  DefaultSizes({
    required Size small,
    required Size medium,
    required Size large,
  })  : _small = small,
        _medium = medium,
        _large = large;

  Size get small => _small;

  Size get medium => _medium;

  Size get large => _large;

  void updateSmall(Size size) => _small = size;

  void updateMedium(Size size) => _medium = size;

  void updateLarge(Size size) => _large = size;

  static final DefaultSizes _instance = DefaultSizes(small: _kSmallSize, medium: _kMediumSize, large: _kLargeSize);

  static DefaultSizes get instance => _instance;
}
