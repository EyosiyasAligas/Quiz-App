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
    final size = MediaQuery.sizeOf(context);
    final isLandScape = size.width > size.height; 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: CustomScrollView(
        slivers: [
          if (isLandScape)
            SliverToBoxAdapter(
              child: buildLandScapeView(),
            )
          else
            SliverToBoxAdapter(
              child: Column(
                children: [
                  buildPreferenceItem('Category', history.quizTitle),
                  buildPreferenceItem('Difficulty', history.difficulty.value.toString()),
                  buildPreferenceItem('Type', history.type.value.toString()),
                  buildPreferenceItem('Total Questions', history.totalQuestions.toString()),
                  buildPreferenceItem('Score', history.score.toString()),
                ],
              ),
            ),
          if (!isLandScape)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final question = history.questions[index];
                  return QuestionCard(
                    isReview: true,
                    question: question,
                    index: index,
                    totalQuestions: history.totalQuestions,
                  );
                },
                childCount: history.totalQuestions,
              ),
            ),
        ],
      ),
    );
  }
  Widget buildPreferenceItem(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(value),
    );
  }

  Widget buildLandScapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.totalQuestions,
            itemBuilder: (context, index) {
              final question = history.questions[index];
              return QuestionCard(
                isReview: true,
                question: question,
                index: index,
                totalQuestions: history.totalQuestions,
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              buildPreferenceItem('Category', history.quizTitle),
              buildPreferenceItem('Difficulty', history.difficulty.value.toString()),
              buildPreferenceItem('Type', history.type.value.toString()),
              buildPreferenceItem('Total Questions', history.totalQuestions.toString()),
              buildPreferenceItem('Score', history.score.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
