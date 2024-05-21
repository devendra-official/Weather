import 'package:flutter/material.dart';
import 'package:weather/core/theme/theme.dart';
import 'package:weather/features/weather_info/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MyHomePage(),
    );
  }
}
