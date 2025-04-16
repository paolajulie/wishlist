import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const WishlistApp());
}

class WishlistApp extends StatelessWidget {
  const WishlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishy',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
        fontFamily: 'Poppins',
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
