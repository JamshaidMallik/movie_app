import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/MoviesScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MoviesScreen(),
    );
  }
}