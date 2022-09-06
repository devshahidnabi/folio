import 'package:flutter/material.dart';
import 'package:folio/homepage.dart';

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
      title: 'Flutter Folio',
      theme: ThemeData(
        fontFamily: 'Barlow',
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}
