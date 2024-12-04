import 'package:flutter/material.dart';
import 'package:quiz_app/core/theme/app_colors.dart';

import '../../domain/entities/question_entity.dart';

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
  });

  final int index;
  final int totalQuestions;
  final QuestionEntity question;
  final Color? shadowColor;
  final Color? color;
  final VoidCallback? onSkipPressed;
  final ValueChanged<String>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    print('answer: ${question.correctAnswer}');
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: color ?? AppColors.white,
        elevation: 5,
        shadowColor: shadowColor?.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(10),
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
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selected: question.selectedAnswer == option,
                    selectedTileColor: themeData.colorScheme.secondary.withOpacity(0.2),
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
