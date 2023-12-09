import 'package:flutter/material.dart';
import 'package:responsi_disti/screen/category_page.dart';
import 'package:responsi_disti/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi',
      debugShowCheckedModeBanner: false,
      home: CategoriesPage(),
    );
  }
}
