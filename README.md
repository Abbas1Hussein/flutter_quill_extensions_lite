# flutter_quill_extensions_lite

```markdown
Flutter package to provide extras to `flutter_quill`.

## Installation

To use the `flutter_quill_extensions_lite` package, you need to add it as a dependency in
your `pubspec.yaml`:

dependencies:
flutter_quill_extensions_lite: ^1.0.0

```

Then, run `flutter pub get` in your terminal to fetch the package.

## Usage

import the required packages and call the `FlutterQuillEmbeds` class to add custom embeds and
toolbar buttons:

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

- **Image**: Adds support for image embeds in the Quill editor.
- **Line**: Allows you to add a custom line and customize its attributes, such as color and bold.

## API Reference

### `FlutterQuillEmbeds`

#### `builders()`

Returns a list of embed builders to provide support for custom embeds.

```dart
 builders({
  ImageBuilders? imageBuilder,
});
```
- `imageBuilder`: An optional parameter that allows you to customize image view. It provides 'image' and 'options', 'readOnly',

#### `buttons()`

This method adds custom buttons to the Quill editor toolbar, such as the image and divider buttons.

```dart
 buttons({
  Tooltips? tooltips,
  Buttons? buttons,
  MediaPickSetting? mediaPickSettingSelector,
  DefaultSizes? defaultSizes,
});
```

- `tooltips`: An optional parameter that allows you to customize tooltips for the buttons. It
  provides 'imageButtonTooltip' and 'dividerButtonTooltip' to set tooltips for the image and divider
  buttons, respectively.

- `buttons`: An optional parameter that allows you to specify which buttons to display. By default,
  both the image and divider buttons are shown, but you can customize this behavior by
  setting 'showImageButton' and 'showDividerButton' properties in the Buttons class.

- `mediaPickSettingSelector`: An optional parameter that allows you to customize media pick, when
  click image button get image from gallery or link.

- `defaultSizes`: An optional parameter that allows you to customize the default sizes for image.

## Exported Components

The `flutter_quill_extensions_lite` package also exports the following components For easy access
and use flutter_quill:

- `QuillControllerUtils`: A utility class extending QuillController to provide additional methods
  for text manipulation.

##### Usage:
```dart
final QuillController controller = QuillController();
controller.utilts;
```

- `ImageUtils`: A utility class providing methods for handling image attributes and embedding
  images.

##### Usage:
```dart
final QuillController controller = QuillController();
controller.utilts.imageUtilts;
```

- `ColorUtils`: A utility class providing static methods for converting color codes to Color objects
  and vice versa.

##### Usage:
```dart
static Color hexToColor(String? hexString);

static String colorToHex(Color color);
```
