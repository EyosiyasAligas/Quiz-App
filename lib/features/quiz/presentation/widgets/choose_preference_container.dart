import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/route/router.dart';
import '../../../../core/utils/helper.dart';
import '../../../../shared/presentation/widgets/custom_button.dart';
import '../../domain/entities/quiz_enums.dart';
import '../../domain/entities/quiz_params.dart';
import '../bloc/choose_preference/choose_preference_cubit.dart';
import '../../domain/entities/category_entity.dart';
import '../bloc/fetch_question/fetch_question_bloc.dart';

class ChoosePreferenceContainer extends StatefulWidget {
  const ChoosePreferenceContainer({super.key, required this.categoryItems});

  final List<CategoryEntity> categoryItems;

  @override
  State<ChoosePreferenceContainer> createState() =>
      _ChoosePreferenceContainerState();
}

class _ChoosePreferenceContainerState extends State<ChoosePreferenceContainer> {
  QuizParams params = QuizParams();

  TextEditingController categoryController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  late Size size;
  late ThemeData themeData;

  bool isMobile = false;

  Timer? timer;

  void increaseOrDecrease(int amount, bool isIncrement) {
    // not working
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (isIncrement && params.amount! < 50) {
        params = params.copyWith(amount: params.amount! + 1);
        amountController.text = params.amount.toString();
      } else if (!isIncrement && params.amount! > 1) {
        params = params.copyWith(amount: params.amount! - 1);
        amountController.text = params.amount.toString();
      }
    });
  }

  void stopIncreaseOrDecrease() {
    timer?.cancel();
  }

  void startQuiz() {
    context.read<FetchQuestionBloc>().add(FetchQuestion(quizParams: params));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = context.read<ChoosePreferenceCubit>().currentParams;

    categoryController.text = widget.categoryItems.first.name;
    difficultyController.text = QuizDifficulty.any.value!;
    typeController.text = QuizType.any.value!;
    amountController.text = params.amount.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoryController.dispose();
    difficultyController.dispose();
    typeController.dispose();
    timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    themeData = Theme.of(context);

    isMobile = ScreenUtil().screenWidth < 600;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDropdownPreference(),
          const SizedBox(height: 20),
          buildAmountPreference(
            key: const Key('amount'),
          ),
          const SizedBox(height: 20),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildDropdownPreference() {
    return Column(
      children: [
        buildDropdownPreferenceItem(
          key: const Key('category'),
          categories: widget.categoryItems,
          menuTitle: 'Choose Category',
          controller: categoryController,
        ),
        const SizedBox(height: 20),
        //difficulty
        buildDropdownPreferenceItem(
          key: const Key('difficulty'),
          difficulties: QuizDifficulty.values,
          menuTitle: 'Choose Difficulty',
          controller: difficultyController,
        ),
        const SizedBox(height: 20),
        //type
        buildDropdownPreferenceItem(
          key: const Key('type'),
          types: QuizType.values,
          menuTitle: 'Choose Type',
          controller: typeController,
        ),
      ],
    );
  }

  Widget buildDropdownPreferenceItem({
    Key? key,
    List<CategoryEntity>? categories,
    List<QuizDifficulty>? difficulties,
    List<QuizType>? types,
    required String menuTitle,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(menuTitle,
            style: themeData.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        DropdownMenu(
          key: key,
          selectedTrailingIcon: const Icon(Icons.arrow_drop_up),
          width: size.width * 0.8,
          menuHeight: size.height * 0.5,
          controller: controller,
          dropdownMenuEntries: [
            if (categories != null)
              ...categories.map((category) {
                return DropdownMenuEntry<int>(
                  value: category.id,
                  label: category.name,
                );
              }),
            if (difficulties != null)
              ...difficulties.map((difficulty) {
                return DropdownMenuEntry<QuizDifficulty>(
                  value: difficulty,
                  label: difficulty.value.toString(),
                );
              }),
            if (types != null)
              ...types.map((type) {
                return DropdownMenuEntry<QuizType>(
                  value: type,
                  label: type.value.toString(),
                );
              }),
          ],
          onSelected: (value) {
            if (menuTitle.contains('Category')) {
              params = params.copyWith(categoryId: value as int);
            } else if (menuTitle.contains('Difficulty')) {
              params = params.copyWith(difficulty: value as QuizDifficulty);
            } else if (menuTitle.contains('Type')) {
              params = params.copyWith(type: value as QuizType);
            }
          },
        ),
      ],
    );
  }

  Widget buildAmountPreference({Key? key}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (params.amount! > 1) {
              params = params.copyWith(amount: params.amount! - 1);
              amountController.text = params.amount.toString();
            }
          },
          onLongPress: () {
            increaseOrDecrease(params.amount!, false);
          },
          onLongPressUp: stopIncreaseOrDecrease,
          child: CircleAvatar(
            backgroundColor: themeData.colorScheme.secondary.withOpacity(0.6),
            radius: 12,
            foregroundColor: themeData.colorScheme.onSecondary,
            child: const Icon(
              Icons.remove,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 10),
        DropdownMenu(
          key: key,
          width: 90,
          trailingIcon: null,
          leadingIcon: null,
          textAlign: TextAlign.end,
          menuHeight: size.height * 0.35,
          controller: amountController,
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          dropdownMenuEntries: List.generate(50, (index) {
            return DropdownMenuEntry<int>(
              value: index + 1,
              label: (index + 1).toString(),
            );
          }),
          onSelected: (value) {
            params = params.copyWith(amount: value as int);
          },
        ),
        // const SizedBox(width: 5),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (params.amount! < 50) {
              params = params.copyWith(amount: params.amount! + 1);
              amountController.text = params.amount.toString();
            }
          },
          onLongPress: () {
            increaseOrDecrease(params.amount!, true);
          },
          onLongPressUp: stopIncreaseOrDecrease,
          child: CircleAvatar(
            backgroundColor: themeData.colorScheme.secondary.withOpacity(0.6),
            radius: 12,
            foregroundColor: themeData.colorScheme.onSecondary,
            child: const Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return BlocConsumer<FetchQuestionBloc, FetchQuestionState>(
      listener: (context, state) {
        if (state is FetchQuestionLoadSuccess) {
          Navigator.of(context).pushReplacementNamed(
            Routes.quizScreen,
            arguments: {
              'questions': state.questions,
              'category': categoryController.text == 'Any'
                  ? 'Random'
                  : categoryController.text,
            },
          );
        } else if (state is FetchQuestionLoadFailure) {
          Helper.showSnackBar(context, state.errorMessage, isError: true);
        }
      },
      builder: (context, state) {
        bool isLoading = state is FetchQuestionLoadInProgress;
        return CustomButton(
            text: 'Start Quiz',
            isLoading: isLoading,
            alignment: Alignment.center,
            onPressed: () => isLoading ? null : startQuiz());
      },
    );
  }
}
