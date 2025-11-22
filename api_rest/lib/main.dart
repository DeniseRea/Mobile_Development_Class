import 'package:flutter/material.dart';
import 'design/homepage.dart';
import 'design/screenWine.dart';

void main() {
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API REST',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      //home: Homepage(),
      home: WinePage(),
    );
  }
}
