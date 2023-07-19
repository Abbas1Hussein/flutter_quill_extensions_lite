import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/translations.dart';

import 'simple.dart';

class RemoveOption extends StatelessWidget {
  final QuillController controller;

  const RemoveOption({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogItem(
      icon: Icons.delete_forever_outlined,
      color: Colors.red.shade200,
      text: 'Remove'.i18n,
      onPressed: () {
        _onPressedHandler();
        Navigator.pop(context);
      },
    );
  }

  void _onPressedHandler() {
    final offset = getEmbedNode(controller, controller.selection.start).offset;
    controller.replaceText(offset, 1, '', TextSelection.collapsed(offset: offset));
  }
}
