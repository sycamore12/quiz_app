import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  // 1. Accept the theme controls
  const WelcomeScreen({
    super.key,
    required this.currentTheme,
    required this.onThemeToggle,
  });

  final ThemeMode currentTheme;
  final void Function(ThemeMode) onThemeToggle;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(userName: _nameController.text),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color startColor =
        isDark ? const Color(0xFF2B0013) : const Color(0xFFF24455);
    final Color endColor =
        isDark ? const Color(0xFF000000) : const Color(0xFF660F24);

    final String logoAsset = isDark
        ? 'assets/images/quiz_logo.png' 
        : 'assets/images/quiz_logo_white.png';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // 2. Use a Stack to layer the toggle over the content
        child: Stack(
          children: [
            // --- 3. Your original centered content ---
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              logoAsset,
                              height: constraints.maxHeight * 0.3,
                              semanticLabel: 'Quiz Logo',
                            ),
                            const SizedBox(height: 20),

                            const Text(
                              'Welcome to Kuis Bentar!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),

                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: Colors.white), 
                              decoration: InputDecoration(
                                labelText: 'Enter your name',
                                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorStyle: TextStyle(color: Colors.yellow.shade300),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow.shade300),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow.shade300, width: 2),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            
                            ElevatedButton(
                              onPressed: _startQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Start Quiz'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- 4. The new Theme Toggle Button ---
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: _ThemeToggleButton(
                    currentTheme: widget.currentTheme,
                    onThemeToggle: widget.onThemeToggle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 5. Helper Widget for the Toggle ---
class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton({
    required this.currentTheme,
    required this.onThemeToggle,
  });

  final ThemeMode currentTheme;
  final void Function(ThemeMode) onThemeToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ToggleButtons(
        // The order is: Light, System, Dark
        isSelected: [
          currentTheme == ThemeMode.light,
          currentTheme == ThemeMode.system,
          currentTheme == ThemeMode.dark,
        ],
        onPressed: (index) {
          // Find the new mode based on which button was tapped
          final mode = [ThemeMode.light, ThemeMode.system, ThemeMode.dark][index];
          onThemeToggle(mode);
        },
        borderRadius: BorderRadius.circular(100),
        selectedColor: Colors.black, // Icon color when selected
        color: Colors.white.withOpacity(0.7), // Icon color when not selected
        fillColor: Colors.white, // Background color when selected
        splashColor: Colors.white.withOpacity(0.2),
        constraints: const BoxConstraints(minHeight: 36, minWidth: 40),
        children: const [
          Icon(Icons.wb_sunny_outlined, size: 20),
          Icon(Icons.brightness_auto_outlined, size: 20),
          Icon(Icons.nightlight_outlined, size: 20),
        ],
      ),
    );
  }
}