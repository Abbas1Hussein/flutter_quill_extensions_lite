import 'package:flutter/material.dart';

enum MediaPickSetting {
  gallery,
  link,
}

enum SizeClassification {
  small,
  medium,
  large,
  originalSize,
}

extension SizeExtension on SizeClassification {
  Size getSizeClassification(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    switch (this) {
      case SizeClassification.small:
        return Size(deviceSize.width * 0.2, deviceSize.height * 0.2);
      case SizeClassification.medium:
        return Size(deviceSize.width / 2, deviceSize.height / 2);
      case SizeClassification.large:
        return Size(deviceSize.width * 0.7, deviceSize.height * 0.7);
      case SizeClassification.originalSize:
        throw 'you can\'t handel originalSize her';
    }
  }
}
