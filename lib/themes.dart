import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff407BFF)),
    useMaterial3: true,
    brightness: Brightness.light);

ThemeData darktMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff407BFF), brightness: Brightness.dark),
  useMaterial3: true,
);
