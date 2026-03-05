import 'package:flutter/material.dart';
import 'package:product/view/product_list_screen.dart';
import 'package:provider/provider.dart';
import 'controller/product_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorSchemeSeed: const Color(0xFF6B3FA0),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}
