// In lib/models/quiz_question.dart

class QuizQuestion {
  // 'const' constructor for an immutable object
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  // A helper method to get a shuffled list of answers for display.
  List<String> getShuffledAnswers() {
    // Creates a new list based on the original 'answers' list
    final shuffledList = List.of(answers);
    // Shuffles the new list in place
    shuffledList.shuffle();
    // Returns the shuffled list
    return shuffledList;
  }
}