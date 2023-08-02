 Flutter package that provides additional features and enhancements to the `flutter_quill` package, which is a rich text editor for Flutter applications. This package adds support for custom embeds like images and allows for easy export and restore of editor content. Here's a brief overview of the installation, features, and API reference:


## Usage

Import the required packages and use the `FlutterQuillEmbeds` class to add custom embeds and toolbar buttons:

```dart
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions_lite/flutter_quill_extensions_lite.dart';

// In the toolbar, use `FlutterQuillEmbeds.buttons`
QuillToolbar.basic(
  controller: controller,
  embedButtons: FlutterQuillEmbeds.buttons(),
);

// In the editor, use `FlutterQuillEmbeds.builders`
QuillEditor.basic(
  controller: controller,
  readOnly: false,
  embedBuilders: FlutterQuillEmbeds.builders(),
);
```

## Features

- **Image**: Adds support for image embeds in the Quill editor. You can customize the image view and choose from different size options.

- **Box**: Provides a custom box element in the editor to enhance the content layout.

- **Divider**: Allows you to add a custom line (divider) and customize its attributes, such as color and bold.

- **Table**: Adds support for creating tables in the Quill editor.

- **Export Data**: Easily export editor content to a text file. You can choose to encode the data in base64 format for added security. Note the Export Data only work in `desktop`

- **Restore Data**: Restore editor content from a previously exported text file. The package automatically detects if the data is encoded in base64 format or json.

## API Reference

### `FlutterQuillEmbeds`

#### `builders()`

Returns a list of embed builders to provide support for custom embeds.

```dart
builders({
  ImageBuilder? imageBuilder,
  TableBuilder? tableBuilder,
  BoxBuilder? boxBuilder,
  DefaultSizes? defaultSizes,
});
```

- `imageBuilder`: allows you to customize the image view. It provides `image` and `attrubets` and `options`, `readOnly`,

- `tableBuilder`: allows you to customize the table view. It provides `attrubets` and `data` and `showEditDialog` and `readOnly`,
- 
- `boxBuilder`: allows you to customize the box view. It provides `attrubets` and `value` and `showEditDialog`, `readOnly`,

- `defaultSizes`: allows you to customize the default sizes for widgets supported.

#### `buttons()`

This method adds custom buttons to the Quill editor toolbar, such as the image and divider buttons etc...

```dart
buttons({
  Tooltips? tooltips,
  Buttons? buttons,
  MediaPickSetting? mediaPickSettingSelector,
  DataOperationSetting? dataOperationSettingSelector,
  bool useBase64 = false,
});
```

- `tooltips`:  allows you to customize tooltips for the buttons.

- `buttons`:  allows you to specify which buttons to display. By default, all are shown.

- `mediaPickSettingSelector`: allows you to customize media pick when clicking the image button to get an image from the gallery or link.

- `dataOperationSettingSelector`:  allows you to customize data operation when clicking the export/restore button.

- `useBase64`: specifies whether to encode the data in base64 format when exporting. Set it to `true` to enable base64 encoding and if it is `false`, the data will be exported as a List of JSON.

### Exported Components

The `flutter_quill_extensions_lite` package also exports the following components for easy access and use with `flutter_quill`:

- `QuillControllerUtils`: A utility class extending `QuillController` to provide additional methods for text manipulation.

##### Usage:
```dart
final QuillController controller = QuillController();
controller.utils;
```

- `AttributesUtils`: A utility class providing getter methods to access various attributes of the editor content. This class is helpful for retrieving information about the text attributes such as color, background color, bold, italic, underline, strike, header, and sizes.

##### Usage:
```dart
final AttributesUtils attributesUtils = AttributesUtils(attributes);

// Accessing attributes
Color? backgroundColor = attributesUtils.backgroundColor; // Color(0xFFFFFF00)
Color? textColor = attributesUtils.color; // Color(0xFF0000FF)
bool isTextBold = attributesUtils.isBold; // true
bool isTextItalic = attributesUtils.isItalic; // false
bool isTextStrike = attributesUtils.isStrike; // false
bool isTextUnderline = attributesUtils.isUnderline; // true
Header? header = attributesUtils.header; // Header.h1
Sizes? size = attributesUtils.sizes; // Sizes.large
```

- `ColorUtils`: A utility class providing static methods for converting color codes to `Color` objects and vice versa.

##### Usage:
```dart
static Color hexToColor(String? hexString);

static String colorToHex(Color color);
```