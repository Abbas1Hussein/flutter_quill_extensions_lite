import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';

import '../../../utils/enum.dart';

/// chose type MediaPickSetting get picture from [link] or [gallery]
class MediaPickSelect extends StatelessWidget {
  const MediaPickSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.collections, color: Colors.orangeAccent),
              label: Text('Gallery'.i18n),
              onPressed: () => Navigator.pop(context, MediaPickSetting.gallery),
            ),
          ),
          const SizedBox(height: 8.0, child: VerticalDivider()),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.link, color: Colors.cyanAccent),
              label: Text('Link'.i18n),
              onPressed: () => Navigator.pop(context, MediaPickSetting.link),
            ),
          ),
        ],
      ),
    );
  }

  Future<MediaPickSetting?> show(BuildContext context) async {
    return showDialog<MediaPickSetting>(context: context, builder: (ctx) => this);
  }
}
