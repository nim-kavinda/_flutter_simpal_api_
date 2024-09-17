import 'package:flutter/material.dart';
import 'package:my_p/pages/all_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AllProducts(),
    );
  }
}
