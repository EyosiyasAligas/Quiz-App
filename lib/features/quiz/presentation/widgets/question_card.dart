import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/theme/app_colors.dart';

import '../../domain/entities/question_entity.dart';
import '../bloc/answer_question/answer_question_bloc.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    this.color,
    this.shadowColor,
    required this.index,
    required this.totalQuestions,
    this.onSkipPressed,
    this.onOptionSelected,
    this.isReview = false,
  });

  final int index;
  final int totalQuestions;
  final QuestionEntity question;
  final Color? shadowColor;
  final Color? color;
  final bool isReview;
  final VoidCallback? onSkipPressed;
  final ValueChanged<String>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    print('answer: ${question.correctAnswer}');

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: color,
        elevation: 10,
        borderOnForeground: true,
        shadowColor: shadowColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question: ${index + 1}/${totalQuestions}',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: themeData.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (!isReview)
                      TextButton(
                        onPressed: onSkipPressed,
                        child: Text(
                          'Skip',
                          style: themeData.textTheme.bodyMedium?.copyWith(
                            color: themeData.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                question.question,
                style: themeData.textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...question.options.map((option) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BlocConsumer<AnswerQuestionBloc, AnswerQuestionState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AnswerQuestionInitial) {
                        return ListTile(
                          // enabled: !isReview,
                          tileColor: isReview
                              ? (question.correctAnswer == option
                                  ? AppColors.successColor.withOpacity(0.5)
                                  : (question.selectedAnswer == option
                                      ? AppColors.errorColor.withOpacity(0.5)
                                      : question.selectedAnswer!.isEmpty ? AppColors.errorColor.withOpacity(0.5) : null))
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: isReview
                              ? null
                              : () {
                                  if (onOptionSelected != null) {
                                    onOptionSelected!(option);
                                  }
                                },
                          title: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else if (state is AnswerQuestionSuccess) {
                        return ListTile(
                          // enabled: !isReview,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          selected:
                              state.questions[index].selectedAnswer == option,
                          selectedTileColor:
                              themeData.colorScheme.secondary.withOpacity(0.2),
                          onTap: () {
                            if (onOptionSelected != null) {
                              onOptionSelected!(option);
                            }
                          },
                          title: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
