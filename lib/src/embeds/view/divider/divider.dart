import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../utils/color.dart';

class DividerWrapper extends StatelessWidget {
  final Map<String, Attribute<dynamic>> attributes;

  const DividerWrapper({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Divider(
      color: attributes.containsKey(Attribute.color.key)
          ? hexToColor(attributes[Attribute.color.key]!.value)
          : (brightness == Brightness.dark ? Colors.white : Colors.black),
      thickness: attributes.containsKey(Attribute.bold.key) ? 5 : null,
    );
  }
}
