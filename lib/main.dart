import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

// These colors are from your quiz screen design
// and will be used for the solid backgrounds on the quiz/results pages.
const _lightRed = Color(0xFFE53935);
const _darkRed = Color(0xFF2E0202);

void main() {
  runApp(const MyApp());
}

// 1. Convert to StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 2. Add state to hold the current theme mode
  // We start with ThemeMode.system, which you liked.
  ThemeMode _themeMode = ThemeMode.system;

  // 3. Add a function to change the theme
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

      // 4. Use the state variable to control the theme
      themeMode: _themeMode,

      // 5. Pass the function and current state to WelcomeScreen
      home: WelcomeScreen(
        currentTheme: _themeMode,
        onThemeToggle: _setThemeMode,
      ),
    );
  }
}