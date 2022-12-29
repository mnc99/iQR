import 'package:flutter/material.dart';
import 'package:iqr/screens/home_screen.dart';
import 'package:iqr/themes/iqr_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iQR',
      theme: AppThemes.darkTheme,
      home: const HomeScreen(),
    );
  }
}
