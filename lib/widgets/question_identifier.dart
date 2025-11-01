import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
    super.key,
    required this.questionIndex,
    required this.isCorrect,
  });

  final int questionIndex;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final number = questionIndex + 1;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCorrect ? Colors.cyan.shade300 : Colors.pink.shade300,
        shape: BoxShape.circle,
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}