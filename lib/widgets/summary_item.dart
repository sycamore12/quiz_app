import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  // We'll pass a Map with all the data for a single question
  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrect = itemData['user_answer'] == itemData['correct_answer'];

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
          // Expanded allows the Column to take all remaining horizontal space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question_text'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your answer: ${itemData['user_answer'] as String}',
                  style: TextStyle(
                    color: Colors.pink.shade100,
                  ),
                ),
                Text(
                  'Correct answer: ${itemData['correct_answer'] as String}',
                  style: TextStyle(
                    color: Colors.cyan.shade100,
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