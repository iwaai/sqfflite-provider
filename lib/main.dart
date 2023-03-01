//packages
import 'package:flutter/material.dart';
//screens
import './screens/homepage.dart';

//provider | models

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

      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const homePage(),
    );
  }
}
