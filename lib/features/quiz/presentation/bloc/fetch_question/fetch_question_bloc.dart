import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../domain/usecases/fetch_quiz_usecase.dart';

part 'fetch_question_event.dart';
part 'fetch_question_state.dart';

class FetchQuestionBloc extends Bloc<FetchQuestionEvent, FetchQuestionState> {
  final FetchQuizUseCase _fetchQuizUseCase;

  FetchQuestionBloc(this._fetchQuizUseCase) : super(FetchQuestionInitial()) {
    on<FetchQuestion>(fetchQuestion);
  }

  fetchQuestion(FetchQuestion event, Emitter<FetchQuestionState> emitter) async {
    emitter(FetchQuestionLoadInProgress());
    final result = await _fetchQuizUseCase.call(event.quizParams);
    try {
      result.fold(
        (failure) => emitter(FetchQuestionLoadFailure(failure.errorMessage)),
        (questions) => emitter(FetchQuestionLoadSuccess(questions)),
      );
    } catch (e) {
      emitter(FetchQuestionLoadFailure(e.toString()));
    }
  }
}
