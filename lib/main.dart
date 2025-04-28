import 'package:flutter/material.dart';
import 'package:gemini_chat/onboarding.dart';
import 'myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff407BFF)),
        useMaterial3: true,
      ),
      darkTheme:  ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff407BFF), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const OnBoarding(),
    );
  }
}


