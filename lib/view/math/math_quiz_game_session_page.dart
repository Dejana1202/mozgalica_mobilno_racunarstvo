import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mozgalica/model/game_result.dart';
import 'package:mozgalica/model/question_model.dart';
import 'package:mozgalica/service/game_service.dart';

class MathQuizGameSessionPage extends StatefulWidget {
  final int totalQuestions;
  final int secondsPerQuestion;
  final String playerName;

  const MathQuizGameSessionPage({
    super.key,
    this.totalQuestions = 10,
    this.secondsPerQuestion = 15,
    required this.playerName,
  });

  @override
  MathQuizGameSessionPageState createState() => MathQuizGameSessionPageState();
}

class MathQuizGameSessionPageState extends State<MathQuizGameSessionPage> {
  late List<QuestionModel> questionList;
  int currentIndex = 0;
  int score = 0;
  int remainingSeconds = 0;
  Timer? questionTimer;
  bool answered = false;
  int? selectedAnswer;
  bool isProcessing = false;

  final Random random = Random();

  @override
  void initState() {
    super.initState();
    startNewQuiz();
  }

  @override
  void dispose() {
    questionTimer?.cancel();
    super.dispose();
  }

  void startNewQuiz() {
    questionTimer?.cancel();
    score = 0;
    currentIndex = 0;
    questionList = List.generate(
      widget.totalQuestions,
      (_) => generateQuestion(),
    );
    startTimer();
    answered = false;
    selectedAnswer = null;
    isProcessing = false;
    setState(() {});
  }

  QuestionModel generateQuestion() {
    final operations = ['+', '-', '×', '÷'];
    final op = operations[random.nextInt(operations.length)];

    int a;
    int b;
    int correct;

    switch (op) {
      case '+':
        a = random.nextInt(50) + 1; // 1..50
        b = random.nextInt(50) + 1;
        correct = a + b;
        break;
      case '-':
        a = random.nextInt(50) + 1;
        b = random.nextInt(a) + 1; // ensure non-negative result
        correct = a - b;
        break;
      case '×':
        a = random.nextInt(12) + 1; // 1..12
        b = random.nextInt(12) + 1;
        correct = a * b;
        break;
      case '÷':
        b = random.nextInt(11) + 2; // 2..12 divisor
        int multiplier = random.nextInt(12) + 1;
        a = b * multiplier; // ensures integer division
        correct = a ~/ b;
        break;
      default:
        a = 1;
        b = 1;
        correct = 2;
    }

    final questionText = op == '÷'
        ? '$a ÷ $b'
        : (op == '×' ? '$a × $b' : '$a $op $b');

    // Generate options: correct + 3 distractors
    final Set<int> optionsSet = {correct};
    while (optionsSet.length < 4) {
      int perturb;
      if (op == '×' || op == '÷') {
        perturb = (random.nextInt(7) - 3); // -3..3
      } else {
        perturb = (random.nextInt(21) - 10); // -10..10
      }
      int candidate =
          correct + (perturb == 0 ? (random.nextBool() ? 1 : -1) : perturb);
      if (candidate < 0) candidate = (candidate.abs() + 2); // avoid negatives
      optionsSet.add(candidate);
    }

    final options = optionsSet.toList();
    options.shuffle(random);

    return QuestionModel(
      questionText: questionText,
      correctAnswer: correct,
      options: options,
    );
  }

  void startTimer() {
    questionTimer?.cancel();
    remainingSeconds = widget.secondsPerQuestion;
    questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (remainingSeconds <= 0) {
        timer.cancel();
        onTimeUp();
      } else {
        setState(() => remainingSeconds -= 1);
      }
    });
    setState(() {});
  }

  void onTimeUp() {
    if (answered || isProcessing) return;
    answered = true;
    selectedAnswer = null;
    isProcessing = true;
    setState(() {});
    // short delay before moving on
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      moveToNextQuestion();
    });
  }

  void submitAnswer(int answer) {
    if (answered || isProcessing) return;

    answered = true;
    selectedAnswer = answer;
    questionTimer?.cancel();

    final currentQuestion = questionList[currentIndex];
    final bool correct = answer == currentQuestion.correctAnswer;

    if (correct) {
      score++;
    }

    setState(() {});

    // short delay to show feedback then move on
    isProcessing = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      moveToNextQuestion();
    });
  }

  void moveToNextQuestion() {
    isProcessing = false;
    answered = false;
    selectedAnswer = null;
    currentIndex += 1;

    if (currentIndex >= questionList.length) {
      GameService.saveResult(
        GameResult(
          userName: widget.playerName,
          score: score,
          gameId: GameService.mathQuiz.id,
          timestamp: DateTime.now(),
        ),
      );

      showEndDialog();
    } else {
      startTimer();
      setState(() {});
    }
  }

  void showEndDialog() {
    questionTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete'),
        content: Text('Score: $score\nQuestions: ${questionList.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startNewQuiz();
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget buildOptionButton(int optionValue) {
    final bool isSelected =
        selectedAnswer != null && selectedAnswer == optionValue;
    final bool isCorrect =
        optionValue == questionList[currentIndex].correctAnswer;

    Color? buttonColor;
    if (answered) {
      if (isSelected) {
        buttonColor = isCorrect ? Colors.green[600] : Colors.red[600];
      } else if (isCorrect) {
        buttonColor = Colors.green[300];
      } else {
        buttonColor = null;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: answered ? null : () => submitAnswer(optionValue),
        child: Text(
          optionValue.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questionList[currentIndex];
    final progress = (currentIndex + 1) / (questionList.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Quiz'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Restart',
            icon: const Icon(Icons.replay),
            onPressed: () {
              startNewQuiz();
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top info row
            Row(
              children: [
                Chip(label: Text('Score: $score')),
                const Spacer(),
                Text('Q ${currentIndex + 1}/${questionList.length}'),
              ],
            ),
            const SizedBox(height: 12),

            // Progress bar and timer
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 6),
                Text('Time: $remainingSeconds s'),
                const Spacer(),
                IconButton(
                  tooltip: 'Skip',
                  onPressed: answered || isProcessing ? null : onTimeUp,
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Question card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 26,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      question.questionText,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (answered)
                      Text(
                        'Correct answer: ${question.correctAnswer}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Options
            ...question.options.map((opt) => buildOptionButton(opt)),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
