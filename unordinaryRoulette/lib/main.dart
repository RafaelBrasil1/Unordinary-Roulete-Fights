import 'package:flutter/material.dart';
import 'package:unordinaryroulette/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnOrdinary Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MenuPage(), // Define a MenuPage como a página inicial
    );
  }
}