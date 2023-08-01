import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../utils/utils.dart';

class DividerView extends StatelessWidget {
  final Map<String, Attribute<dynamic>> attributes;

  const DividerView({
    super.key,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Divider(
      color: attributesUtils.color ?? (brightness == Brightness.dark ? Colors.white : Colors.black),
      thickness: attributesUtils.isBold ? 5 : null,
    );
  }

  AttributesUtils get attributesUtils => AttributesUtils(attributes);
}
