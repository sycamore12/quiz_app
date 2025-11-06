import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrect = itemData['user_answer'] == itemData['correct_answer'];
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    // --- FIX: Define text colors based on theme brightness ---
    final Color correctAnswerColor = theme.brightness == Brightness.light
        ? Colors.cyan.shade700  // Dark cyan for light mode
        : Colors.cyan.shade100; // Light cyan for dark mode

    final Color wrongAnswerColor = theme.brightness == Brightness.light
        ? Colors.pink.shade700   // Dark pink for light mode
        : Colors.pink.shade100;  // Light pink for dark mode

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            questionIndex: itemData['question_index'] as int,
            isCorrect: isCorrect,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question_text'] as String,
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your answer: ${itemData['user_answer'] as String}',
                  style: TextStyle(
                    color: isCorrect ? correctAnswerColor : wrongAnswerColor,
                  ),
                ),
                Text(
                  'Correct answer: ${itemData['correct_answer'] as String}',
                  style: TextStyle(
                    color: correctAnswerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}