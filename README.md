# flutter_quill_extensions_lite

`flutter_quill_extensions_lite` is a Flutter package that provides additional features and enhancements to the `flutter_quill` package, which is a rich text editor for Flutter applications. This package adds support for custom embeds like images and allows for easy export and restore of editor content. Here's a brief overview of the installation, features, and API reference:

## Installation

To use the `flutter_quill_extensions_lite` package, you need to add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_quill_extensions_lite: ^1.0.0
```

Then, run `flutter pub get` in your terminal to fetch the package.

## Usage

Import the required packages and use the `FlutterQuillEmbeds` class to add custom embeds and toolbar buttons:

```dart
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions_lite/flutter_quill_extensions_lite.dart';

// In the toolbar, use `FlutterQuillEmbeds.buttons`
QuillToolbar.basic(
  controller: controller,
  embedButtons: FlutterQuillEmbeds.buttons(
    tooltips: Tooltips(
      imageButtonTooltip: 'Insert image',
      dividerButtonTooltip: 'Insert divider',
      DataOperationButtonTooltip: 'export/import',
    ),
    buttons: Buttons(
      showImageButton: true,
      showDividerButton: false,
      showDataOperationButtonTooltip: true,
    ),
    mediaPickSettingSelector: MediaPickSetting.gallery,
    useBase64: true,
  ),
);

// In the editor, use `FlutterQuillEmbeds.builders`
QuillEditor.basic(
  controller: controller,
  readOnly: false,
  embedBuilders: FlutterQuillEmbeds.builders(
    imageBuilder: (image, options, readOnly) {
      if (readOnly) {
        return ClipRRect(
          borderRadius: BorderRadiusDirectional.circular(8.0),
          child: image,
        );
      } else {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [options.remove, options.boxFit],
            ),
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(8.0),
              child: image,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                options.sizeClassification,
                options.alignment
              ],
            ),
          ],
        );
      }
    },
    defaultSizes: DefaultSizes(
      small: const Size(100, 100),
      medium: const Size(399, 299),
      large: const Size(899, 499),
    ),
  ),
);
```

## Features

- **Image**: Adds support for image embeds in the Quill editor. You can customize the image view and choose from different size options.

- **Divider**: Allows you to add a custom line (divider) and customize its attributes, such as color and bold.

- **Export Data**: Easily export editor content to a text file. You can choose to encode the data in base64 format for added security.

- **Restore Data**: Restore editor content from a previously exported text file. The package automatically detects if the data is encoded in base64 format or json.

## API Reference

### `FlutterQuillEmbeds`

#### `builders()`

Returns a list of embed builders to provide support for custom embeds.

```dart
builders({
  ImageBuilders? imageBuilder,
  DefaultSizes? defaultSizes,
});
```

- `imageBuilder`: An optional parameter that allows you to customize the image view. It provides 'image' and 'options', 'readOnly',

- `defaultSizes`: An optional parameter that allows you to customize the default sizes for images.

#### `buttons()`

This method adds custom buttons to the Quill editor toolbar, such as the image and divider buttons.

```dart
buttons({
  Tooltips? tooltips,
  Buttons? buttons,
  MediaPickSetting? mediaPickSettingSelector,
  bool useBase64 = false,
});
```

- `tooltips`: An optional parameter that allows you to customize tooltips for the buttons. It provides 'imageButtonTooltip' and 'dividerButtonTooltip' to set tooltips for the image and divider buttons, respectively.

- `buttons`: An optional parameter that allows you to specify which buttons to display. By default, both the image and divider buttons are shown, but you can customize this behavior by setting 'showImageButton' and 'showDividerButton' properties in the Buttons class.

- `mediaPickSettingSelector`: An optional parameter that allows you to customize media pick when clicking the image button to get an image from the gallery or link.

- `useBase64`: An optional parameter that specifies whether to encode the data in base64 format when exporting. Set it to `true` to enable base64 encoding and if it is `false`, the data will be exported as a List of JSON.

### Exported Components

The `flutter_quill_extensions_lite` package also exports the following components for easy access and use with `flutter_quill`:

- `QuillControllerUtils`: A utility class extending `QuillController` to provide additional methods for text manipulation.

##### Usage:
```dart
final QuillController controller = QuillController();
controller.utils;
```

- `ImageUtils`: A utility class providing methods for handling image attributes and embedding images.

##### Usage:
```dart
final QuillController controller = QuillController();
controller.utils.imageUtils;
```

- `ColorUtils`: A utility class providing static methods for converting color codes to `Color` objects and vice versa.

##### Usage:
```dart
static Color hexToColor(String? hexString);

static String colorToHex(Color color);
```