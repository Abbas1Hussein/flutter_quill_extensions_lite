import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'desktop/image.dart';
import 'mobile/image.dart';

class AdaptiveImageView extends StatelessWidget {
  final QuillController controller;
  final Image image;
  final String imageUrl;

  const AdaptiveImageView({
    super.key,
    required this.controller,
    required this.image,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile()) {
      return MobileImageView(controller: controller, image: image);
    } else {
      return DesktopImageView(controller: controller, image: image, imageUrl: imageUrl);
    }
  }
}
