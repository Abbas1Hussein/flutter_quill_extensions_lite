# flutter_quill_extensions_lite

<!--
A Dart package for flutter quill,
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

![Preview](https://drive.google.com/file/d/1n7GzoyMHJVmx2ptS0MoMKdpRUsZpW9bq/view?usp=drive_link)


## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

```dart
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions_lite/flutter_quill_extensions_lite.dart';

// in toolbar use flutterQuillEmbeds.buttons
QuillToolbar.basic(
controller: controller,
embedButtons: FlutterQuillEmbeds.buttons(),
);
// in editor use flutterQuillEmbeds.builders
QuillEditor.basic(
controller: controller,
readOnly: false,
embedBuilders: FlutterQuillEmbeds.builders(),
),

```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
