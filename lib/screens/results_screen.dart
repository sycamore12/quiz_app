import 'package:flutter/material.dart';
import 'package:quiz_app/data/dummy_questions.dart';
import 'package:quiz_app/main.dart'; // Import for MyApp
import 'package:quiz_app/widgets/summary_item.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.userName,
    required this.chosenAnswers,
  });

  final String userName;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question_text': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  int get numCorrectAnswers {
    return summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    return Scaffold(
      // --- FIX: Use the solid theme background color ---
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * 0.9,
                height: constraints.maxHeight * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Congrats, $userName!',
                      style: TextStyle(
                        color: onBackgroundColor, // Use theme color
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'You answered $numCorrectAnswers out of $numTotalQuestions questions correctly!',
                      style: TextStyle(
                        color: onBackgroundColor.withOpacity(0.8), // Use theme color
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: summaryData.map((data) {
                            return SummaryItem(data);
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.refresh, color: onBackgroundColor), // Use theme color
                      label: Text(
                        'Restart Quiz',
                        style: TextStyle(color: onBackgroundColor, fontSize: 16), // Use theme color
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}