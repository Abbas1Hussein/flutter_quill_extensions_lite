import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';

import '../../../utils/enum.dart';

class MediaPickSelect extends StatelessWidget {
  const MediaPickSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // get picture from gallery
          TextButton.icon(
            icon: const Icon(Icons.collections, color: Colors.orangeAccent),
            label: Text('Gallery'.i18n),
            onPressed: () => Navigator.pop(context, MediaPickSetting.gallery),
          ),
          // get picture from url
          TextButton.icon(
            icon: const Icon(Icons.link, color: Colors.cyanAccent),
            label: Text('Link'.i18n),
            onPressed: () => Navigator.pop(context, MediaPickSetting.link),
          )
        ],
      ),
    );
  }
}
