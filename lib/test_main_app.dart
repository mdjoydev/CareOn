import 'package:flutter/material.dart';
import 'screens/main_app.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareOn Test',
      debugShowCheckedModeBanner: false,
      home: const MainApp(),
    );
  }
}