// Mocks generated by Mockito 5.4.4 from annotations
// in quiz_app/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart'
    as _i4;
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuizModel_1 extends _i1.SmartFake implements _i3.QuizModel {
  _FakeQuizModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [QuizImplApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuizImplApi extends _i1.Mock implements _i4.QuizImplApi {
  MockQuizImplApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.QuizModel> get dummyQuizData => (super.noSuchMethod(
        Invocation.getter(#dummyQuizData),
        returnValue: <_i3.QuizModel>[],
      ) as List<_i3.QuizModel>);

  @override
  set dummyQuizData(List<_i3.QuizModel>? _dummyQuizData) => super.noSuchMethod(
        Invocation.setter(
          #dummyQuizData,
          _dummyQuizData,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);

  @override
  String get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.getter(#url),
        ),
      ) as String);

  @override
  _i6.Future<List<_i3.QuizModel>> fetchQuiz() => (super.noSuchMethod(
        Invocation.method(
          #fetchQuiz,
          [],
        ),
        returnValue: _i6.Future<List<_i3.QuizModel>>.value(<_i3.QuizModel>[]),
      ) as _i6.Future<List<_i3.QuizModel>>);

  @override
  _i6.Future<_i3.QuizModel> addQuiz(_i3.QuizModel? quiz) => (super.noSuchMethod(
        Invocation.method(
          #addQuiz,
          [quiz],
        ),
        returnValue: _i6.Future<_i3.QuizModel>.value(_FakeQuizModel_1(
          this,
          Invocation.method(
            #addQuiz,
            [quiz],
          ),
        )),
      ) as _i6.Future<_i3.QuizModel>);
}