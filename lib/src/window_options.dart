import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const windowOptions = WindowOptions(
  title: 'Y&Y',
//size: Size(1500, 740),
//minimumSize: Size(1500, 740),
  size: Size(1280, 750),
  minimumSize: Size(1280, 750),
  center: true,
//fullScreen: true,
  backgroundColor: Colors.transparent,
  skipTaskbar: false,
  titleBarStyle: TitleBarStyle.normal,
);
