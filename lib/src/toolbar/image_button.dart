import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_utils.dart';
import '../utils/index.dart';

/// A button widget for adding images to the Quill editor toolbar.
class ImageToolbarButton extends StatelessWidget {
  const ImageToolbarButton({
    required this.icon,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.mediaPickSettingSelector,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color? fillColor;
  final QuillController controller;
  final MediaPickSettingSelector? mediaPickSettingSelector;
  final QuillIconTheme? iconTheme;
  final QuillDialogTheme? dialogTheme;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor =
        iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);

    return QuillIconButton(
      icon: Icon(icon, size: iconSize, color: iconColor),
      tooltip: tooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => _onPressedHandler(context),
    );
  }

  /// Handles the button press event.
  Future<void> _onPressedHandler(BuildContext context) async {
    final selector = mediaPickSettingSelector ?? ImageUtils.selectMediaPickView;
    await selector(context).then(
      (source) {
        if (source != null) {
          if (source == MediaPickSetting.gallery) {
            _pickImage(context);
          } else {
            _typeLink(context);
          }
        }
      },
    );
  }

  /// Picks an image from the gallery.
  void _pickImage(BuildContext context) => handleImageButtonTap(
        context,
        controller,
      );

  /// For image picking logic
  Future<void> handleImageButtonTap(
    BuildContext context,
    QuillController controller,
  ) async {
    final multiPickedImage = await ImagePicker().pickMultiImage();
    if (multiPickedImage.isNotEmpty) {
      // if we have only one image has selected added without name picture
      if (multiPickedImage.length == 1) {
        _insertToQuillEditor(BlockEmbed.image(multiPickedImage.first.path));
      } else {
        // added multiPickedPicture with name image
        for (var pickedImage in multiPickedImage) {
          _insertToQuillEditor('${pickedImage.name}\n');
          _insertToQuillEditor(BlockEmbed.image(pickedImage.path));
        }
      }
    }
  }


  // final bytes = (await pickedFile.readAsBytes());
  // base64.encode(bytes)

  /// Opens a dialog to type a link.
  void _typeLink(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (_) => LinkToolbarDialog(dialogTheme: dialogTheme),
    ).then(_linkSubmitted);
  }

  /// Handles the submitted link from the dialog.
  void _linkSubmitted(String? value) {
    if (value != null && value.isNotEmpty) {
      _insertToQuillEditor(BlockEmbed.image(value));
    }
  }

  /// add object to quill editor
  void _insertToQuillEditor(Object object) {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;
    controller.replaceText(index, length, object, null);
  }
}

/// A dialog for entering a link.
class LinkToolbarDialog extends StatefulWidget {
  const LinkToolbarDialog({
    this.dialogTheme,
    this.link,
    Key? key,
  }) : super(key: key);

  final QuillDialogTheme? dialogTheme;
  final String? link;

  @override
  LinkToolbarDialogState createState() => LinkToolbarDialogState();
}

class LinkToolbarDialogState extends State<LinkToolbarDialog> {
  late String _link;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _link = widget.link ?? '';
    _controller = TextEditingController(text: _link);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.dialogTheme?.dialogBackgroundColor,
      content: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: widget.dialogTheme?.inputTextStyle,
        decoration: InputDecoration(
          labelText: 'Paste a link'.i18n,
          labelStyle: widget.dialogTheme?.labelTextStyle,
          floatingLabelStyle: widget.dialogTheme?.labelTextStyle,
        ),
        autofocus: true,
        onChanged: _linkChanged,
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: _link.isNotEmpty &&
                  AutoFormatMultipleLinksRule.linkRegExp.hasMatch(_link)
              ? _applyLink
              : null,
          child: Text(
            'Ok'.i18n,
            style: widget.dialogTheme?.labelTextStyle,
          ),
        ),
      ],
    );
  }

  /// Updates the link value when it changes.
  void _linkChanged(String value) => setState(() => _link = value);

  /// Applies the link and closes the dialog.
  void _applyLink() => Navigator.pop(context, _link.trim());
}
