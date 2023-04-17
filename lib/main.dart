import 'package:flutter/material.dart';
import 'package:progress_bar/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Progress Bar',
      home: HomePage(),
    );
  }
}






