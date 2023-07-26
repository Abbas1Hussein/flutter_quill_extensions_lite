import 'package:flutter/material.dart';

import 'index.dart';

typedef MediaPickSettingSelector = Future<MediaPickSetting?> Function(
  BuildContext context,
);

typedef ImageBuilder = Widget Function(Image image, OptionsImage options, bool readOnly);
