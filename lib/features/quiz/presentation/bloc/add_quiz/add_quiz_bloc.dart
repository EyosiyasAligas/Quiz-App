import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_entity.dart';
import '../../../domain/usecases/add_quiz_usecase.dart';

part 'add_quiz_event.dart';
part 'add_quiz_state.dart';

class AddQuizBloc extends Bloc<AddQuizEvent, AddQuizState> {
  final AddQuizUseCase _addQuizUseCase;

  AddQuizBloc(this._addQuizUseCase) : super(AddQuizInitial()) {
    on<AddQuiz>(addQuiz);
  }

  addQuiz(AddQuiz event, Emitter<AddQuizState> emitter) async {
    emitter(AddQuizLoading());
    final result = await _addQuizUseCase(event.quiz);
    print('Add result: $result');
    result.fold(
      (l) => emitter(AddQuizFailure(l.toString())),
      (r) => emitter(AddQuizSuccess('Quiz Added SuccessFully', r)),
    );
  }
}
