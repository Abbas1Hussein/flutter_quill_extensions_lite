import 'package:flutter_quill/flutter_quill.dart';

abstract class BaseModel {
  Map<String, dynamic> toJson();

  Attribute toAttribute() => DataAttribute(toJson());
}
