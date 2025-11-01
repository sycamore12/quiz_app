import 'package:flutter/material.dart';
import 'package:quiz_app/data/dummy_questions.dart';
import 'package:quiz_app/screens/welcome_screen.dart';
import 'package:quiz_app/widgets/summary_item.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.userName,
    required this.chosenAnswers,
  });

  final String userName;
  final List<String> chosenAnswers;

  // A helper method (getter) to process the answers
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question_text': questions[i].text,
        'correct_answer': questions[i].answers[0], // 0 is always correct
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  // A helper to calculate the score
  int get numCorrectAnswers {
    // We can use the summaryData we just generated
    return summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;

    return Scaffold(
      body: Container(
        // Same gradient as the quiz screen for consistency
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * 0.9, // 90% of screen width
                height: constraints.maxHeight * 0.8, // 80% of screen height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    // The scrollable summary list
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
                        // Navigate back to the Welcome Screen to restart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
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
      ),
    );
  }
}