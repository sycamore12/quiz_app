// In lib/widgets/answer_button.dart
import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  final String answerText;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the state
    Color getButtonColor() {
      if (!isAnswered) {
        // Not answered yet - default state
        return Theme.of(context).colorScheme.surface; // Card color
      }
      if (isCorrect) {
        // This is the correct answer
        return Colors.green.shade100;
      }
      if (isSelected) {
        // This is the (wrong) answer the user selected
        return Colors.red.shade100;
      }
      // This is another wrong answer, not selected
      return Theme.of(context).colorScheme.surface; // Card color
    }

    // Determine the text color
    Color getTextColor() {
      if (!isAnswered) {
        return Theme.of(context).colorScheme.onSurface; // Default text color
      }
      if (isCorrect) {
        return Colors.green.shade900;
      }
      if (isSelected) {
        return Colors.red.shade900;
      }
      return Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    }

    // Determine border color
    Color getBorderColor() {
      if (!isAnswered) {
        return Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
      }
      if (isCorrect) {
        return Colors.green.shade900;
      }
      if (isSelected) {
        return Colors.red.shade900;
      }
      return Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        // Disable the button after an answer is chosen
        onPressed: isAnswered ? null : onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          backgroundColor: getButtonColor(),
          side: BorderSide(color: getBorderColor()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // Disables the splash effect when button is disabled
          splashFactory: isAnswered ? NoSplash.splashFactory : null,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            answerText,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: getTextColor(),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}