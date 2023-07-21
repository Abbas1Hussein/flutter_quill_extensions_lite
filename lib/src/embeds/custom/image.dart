import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CustomImageEmbeddable extends Embeddable {
  static const String imageType = 'image';

  CustomImageEmbeddable(Image data) : super(imageType, data);
}

