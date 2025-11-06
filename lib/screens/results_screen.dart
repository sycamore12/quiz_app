import 'package:flutter/material.dart';
import 'package:quiz_app/data/dummy_questions.dart';
import 'package:quiz_app/widgets/summary_item.dart';
import 'package:quiz_app/main.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    // 1. Add userName back
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

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth * 0.9,
              height: constraints.maxHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2. Restore userName text
                  Text(
                    'Congrats, $userName!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You answered $numCorrectAnswers out of $numTotalQuestions questions correctly!',
                    style: const TextStyle(
                      color: Colors.white70,
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
                      // 3. Restart the MyApp widget to pass theme state
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      'Restart Quiz',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}