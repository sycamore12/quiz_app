import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

// These colors are from your quiz screen design
// and will be used for the solid backgrounds on the quiz/results pages.
const _lightRed = Color(0xFFE53935);
const _darkRed = Color(0xFF2E0202);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis Bentar',
      debugShowCheckedModeBanner: false,

      // --- Light Theme (for Quiz/Results screens) ---
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _lightRed,
          brightness: Brightness.light,
          background: _lightRed,
          surface: const Color(0xFFFFFBEF), // Off-white card
          onSurface: Colors.black,
          onBackground: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // --- Dark Theme (for Quiz/Results screens) ---
      darkTheme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _darkRed,
          brightness: Brightness.dark,
          background: _darkRed,
          surface: const Color(0xFF2C2C2C), // Dark grey card
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // Use the phone's system setting automatically
      themeMode: ThemeMode.system,

      // Start at the WelcomeScreen
      home: const WelcomeScreen(),
    );
  }
}