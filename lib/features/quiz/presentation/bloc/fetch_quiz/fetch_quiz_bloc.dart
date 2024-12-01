import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_entity.dart';
import '../../../domain/usecases/fetch_quiz_usecase.dart';

part 'fetch_quiz_event.dart';
part 'fetch_quiz_state.dart';

class FetchQuizBloc extends Bloc<FetchQuizEvent, FetchQuizState> {
  final FetchQuizUseCase _fetchQuizUseCase;

  FetchQuizBloc(this._fetchQuizUseCase) : super(FetchQuizInitial()) {
    on<FetchQuiz>(fetchQuiz);
  }

  fetchQuiz(FetchQuiz event, Emitter<FetchQuizState> emitter) async {
    emitter(FetchQuizLoadInProgress());
    final result = await _fetchQuizUseCase();
    result.fold(
      (l) => emitter(FetchQuizLoadFailure(l.toString())),
      (r) => emitter(FetchQuizLoadSuccess(r)),
    );
  }
}
