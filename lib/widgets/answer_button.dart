import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add vertical padding between buttons
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          // Use a color from your theme
          backgroundColor: Colors.deepPurple.shade400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Montserrat', // Ensures our custom font
            fontSize: 16,
          ),
        ),
        // The parent 'Column' in the quiz screen will
        // be set to stretch, so this button will fill the width.
        child: Text(answerText, textAlign: TextAlign.center),
      ),
    );
  }
}