import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../domain/entities/quiz_enums.dart';

part 'choose_preference_state.dart';

class ChoosePreferenceCubit extends Cubit<ChoosePreferenceState> {
  ChoosePreferenceCubit()
      : super(
          ChoosePreferenceInitial(
            params: QuizParams(
              categoryId: null,
              amount: 10,
              difficulty: QuizDifficulty.any,
              type: QuizType.any,
            ),
          ),
        );

  get currentParams => (state as ChoosePreferenceInitial).params;

  void updatePreferences({required QuizParams params}) {
    emit(
      ChoosePreferenceUpdated(
        params: QuizParams().copyWith(
          amount: params.amount ?? 10,
          categoryId: params.categoryId,
          difficulty: params.difficulty,
          type: params.type,
        ),
      ),
    );
  }

  // QuizParams? getUpdatedPreferences() {
  //   return (state as ChoosePreferenceUpdated).params;
  // }

  void resetPreferences() {
    emit(ChoosePreferenceInitial(
      params: QuizParams(
        categoryId: null,
        amount: 10,
        difficulty: QuizDifficulty.any,
        type: QuizType.any,
      ),
    ));
  }
}
