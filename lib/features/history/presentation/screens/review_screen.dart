import 'package:flutter/material.dart';

import '../../../quiz/presentation/widgets/question_card.dart';
import '../../domain/entities/history_entity.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.history});

  final HistoryEntity history;

  static Route route(RouteSettings routeSettings) {
    final args = routeSettings.arguments as HistoryEntity;
    return MaterialPageRoute(
      builder: (_) => ReviewScreen(history: args),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Score: ${history.score}'),
            Text('Total Questions: ${history.totalQuestions}'),
            Text('Quiz Title: ${history.quizTitle}'),
            Text('Quiz Type: ${history.type}'),
            Text('Quiz Difficulty: ${history.difficulty}'),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final question = history.questions[index];
                  return QuestionCard(
                    isReview: true,
                    question: question,
                    index: index,
                    totalQuestions: history.totalQuestions,
                  );
                },
                itemCount: history.totalQuestions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
