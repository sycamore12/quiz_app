import 'package:flutter/material.dart';
import 'package:quiz_app/data/dummy_questions.dart';
import 'package:quiz_app/screens/results_screen.dart';
import 'package:quiz_app/widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.userName});

  final String userName;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var _currentQuestionIndex = 0;
  final List<String> _userAnswers = [];
  String? _selectedAnswer;

  late List<String> _currentShuffledAnswers;

  @override
  void initState() {
    super.initState();
    _currentShuffledAnswers = questions[_currentQuestionIndex].getShuffledAnswers();
  }

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
            userName: widget.userName,
            chosenAnswers: _userAnswers,
          ),
        ),
      );
    } else {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; 
        _currentShuffledAnswers = questions[_currentQuestionIndex].getShuffledAnswers();
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
          
          // --- 1. WRAP THE COLUMN WITH SingleChildScrollView ---
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- TOP BAR: Progress ---
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
                
                // --- 2. REPLACE Spacer WITH SizedBox ---
                const SizedBox(height: 30),

                // --- QUESTION CARD ---
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Question Text ---
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

                      // --- Answer Buttons ---
                      ..._currentShuffledAnswers.map((answer) {
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

                      // --- "Next" Button (Conditional) ---
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
                
                // --- 3. REPLACE Spacer WITH SizedBox FOR BOTTOM PADDING ---
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}