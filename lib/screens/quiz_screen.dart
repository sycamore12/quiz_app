import 'package:flutter/material.dart';
import 'package:quiz_app/data/dummy_questions.dart';
import 'package:quiz_app/screens/results_screen.dart';
import 'package:quiz_app/widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  // 1. Add userName back
  const QuizScreen({super.key, required this.userName});

  final String userName;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var _currentQuestionIndex = 0;
  final List<String> _userAnswers = [];
  
  String? _selectedAnswer;

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswer == null) return; 

    _userAnswers.add(_selectedAnswer!);

    if (_userAnswers.length == questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            // 2. Pass userName to ResultsScreen
            userName: widget.userName, 
            chosenAnswers: _userAnswers,
          ),
        ),
      );
    } else {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentQuestionIndex];
    final bool isAnswered = _selectedAnswer != null;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '${_currentQuestionIndex + 1} of ${questions.length}',
                  style: TextStyle(
                    color: theme.colorScheme.onBackground.withOpacity(0.8),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey.withOpacity(0.2),
                color: Colors.green.shade400,
                minHeight: 6,
                borderRadius: BorderRadius.circular(100),
              ),
              const Spacer(flex: 1),

              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      currentQuestion.text,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    ...currentQuestion.getShuffledAnswers().map((answer) {
                      final isCorrect = answer == currentQuestion.answers[0];
                      final isSelected = answer == _selectedAnswer;
                      return AnswerButton(
                        answerText: answer,
                        isSelected: isSelected,
                        isCorrect: isCorrect,
                        isAnswered: isAnswered,
                        onTap: () => _answerQuestion(answer),
                      );
                    }),

                    if (isAnswered)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: const Text('Next'),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}