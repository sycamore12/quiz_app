// In lib/data/dummy_questions.dart

import 'package:quiz_app/models/quiz_question.dart';

// This is a 'const' list, meaning it's created at compile-time
// and is highly optimized.
const questions = [
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?',
    [
      'Widgets', // Correct answer
      'Components',
      'Blocks',
      'Elements',
    ],
  ),
  QuizQuestion(
    'Which programming language is used by Flutter?',
    [
      'Dart', // Correct answer
      'Java',
      'Swift',
      'Kotlin',
    ],
  ),
  QuizQuestion(
    'What widget would you use for a scrollable list?',
    [
      'ListView', // Correct answer
      'Row',
      'Column',
      'Stack',
    ],
  ),
  QuizQuestion(
    'What does "State" mean in Flutter?',
    [
      'Data that can change over time', // Correct answer
      'A screen or a page',
      'A type of widget',
      'A programming error',
    ],
  ),
  QuizQuestion(
    'How do you update the UI of a StatefulWidget?',
    [
      'Call setState()', // Correct answer
      'Call updateUI()',
      'Rebuild the widget manually',
      'Change the variable directly',
    ],
  ),
];