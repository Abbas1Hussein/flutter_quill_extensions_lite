import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../image.dart';
import 'simple.dart';

class SaveOption extends StatelessWidget {
  final String imageUrl;

  const SaveOption({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogItem(
      icon: Icons.save,
      color: Colors.greenAccent,
      text: 'Save'.i18n,
      onPressed: () {
        GallerySaver.saveImage(appendFileExtensionToImageUrl(imageUrl)).then(
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saved'.i18n)),
            );
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
