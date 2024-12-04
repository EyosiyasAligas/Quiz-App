import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'submit_quiz_event.dart';
part 'submit_quiz_state.dart';

class SubmitQuizBloc extends Bloc<SubmitQuizEvent, SubmitQuizState> {
  SubmitQuizBloc() : super(SubmitQuizInitial()) {
    on<SubmitQuiz>(submitQuiz);
    on<SubmitQuizUpdated>(submitQuizUpdated);
  }

  int score = 0;

  submitQuiz(SubmitQuiz event, Emitter<SubmitQuizState> emitter) async {
    emitter(SubmitQuizSuccess(event.score));
  }

  submitQuizUpdated(SubmitQuizUpdated event, Emitter<SubmitQuizState> emitter) async {
    emitter(SubmitQuizInitial());
    score = score + event.score;
    emitter(SubmitQuizUpdating(score));
  }
}
