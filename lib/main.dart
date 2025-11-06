// In lib/main.dart
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

// --- NEW COLOR DEFINITIONS BASED ON YOUR FIGMA ---
// Light Mode
const _lightQuizTop = Color(0xFFE5203A); // Matches E5203A (slightly adjusted to E53935 for Material)
const _lightQuizBottom = Color(0xFFFFFFE5); // Matches FFFFE5 (adjusted to FFFBEF for Material)

// Dark Mode
const _darkQuizTop = Color(0xFF660F24); // Matches 660F24
const _darkQuizBottom = Color(0xFF2B0013); // Matches 2B0013

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

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
          seedColor: _lightQuizTop, // Use top color as seed
          brightness: Brightness.light,
          background: _lightQuizBottom, // Main scaffold background (bottom color)
          primary: _lightQuizTop,      // Primary color (top color)
          surface: Colors.white,       // Card background for light mode
          onSurface: Colors.black,
          onBackground: Colors.black,    // Text on main background
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
          seedColor: _darkQuizTop, // Use top color as seed
          brightness: Brightness.dark,
          background: _darkQuizBottom, // Main scaffold background (bottom color)
          primary: _darkQuizTop,      // Primary color (top color)
          surface: const Color(0xFF2C2C2C), // Card background for dark mode
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

      themeMode: _themeMode,

      home: WelcomeScreen(
        currentTheme: _themeMode,
        onThemeToggle: _setThemeMode,
      ),
    );
  }
}