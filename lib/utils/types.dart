import 'dart:io';

import 'package:flutter/material.dart';

typedef OnImagePickCallback = Future<String?> Function(File file);
typedef OnVideoPickCallback = Future<String?> Function(File file);

typedef MediaPickSettingSelector = Future<MediaPickSetting?> Function(
  BuildContext context,
);

enum MediaPickSetting { gallery, link, camera, video }
