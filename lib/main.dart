import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      // Set the theme for the entire app
      theme: ThemeData(
        fontFamily: 'Montserrat', // Our custom font
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // We'll create this WelcomeScreen in the next step
      home: const Scaffold(
        body: Center(
          child: Text("Welcome Screen placeholder"),
        ),
      ),
    );
  }
}