import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Controller to manage the text field's input
  final _nameController = TextEditingController();

  // A key to validate the form
  final _formKey = GlobalKey<FormState>();

  void _startQuiz() {
    // Validate the form. If it's valid, proceed.
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // Pass the name to the QuizScreen again
          builder: (context) => QuizScreen(userName: _nameController.text),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- 1. Define gradient colors from your Figma ---
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color startColor =
        isDark ? const Color(0xFF2B0013) : const Color(0xFFF24455);
    final Color endColor =
        isDark ? const Color(0xFF000000) : const Color(0xFF660F24);

    // --- 2. Define logo asset based on theme ---
    final String logoAsset = isDark
        ? 'assets/images/quiz_logo.png' // Original logo for dark theme
        : 'assets/images/quiz_logo_white.png'; // White logo for light theme

    return Scaffold(
      body: Container(
        // --- 3. Apply the gradient background ---
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  // Use a percentage of screen width for padding
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // --- 4. The Theme-Aware Logo ---
                        Image.asset(
                          logoAsset,
                          height: constraints.maxHeight * 0.3,
                          semanticLabel: 'Quiz Logo',
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Welcome to Kuis Bentar!',
                          // --- 5. Style text to be visible on gradient ---
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // --- 6. Style TextFormField to be visible ---
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white), // Input text
                          decoration: InputDecoration(
                            labelText: 'Enter your name',
                            labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            // White border
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                            // White border when focused
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // Error text style
                            errorStyle: TextStyle(color: Colors.yellow.shade300),
                            // Error border
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
                        
                        // --- 7. Style Button ---
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
      ),
    );
  }
}