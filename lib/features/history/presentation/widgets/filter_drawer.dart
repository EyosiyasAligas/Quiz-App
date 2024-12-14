import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/history/domain/entities/filter_params_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_enums.dart';
import 'package:quiz_app/shared/presentation/widgets/custom_button.dart';

import '../bloc/fetch_history/fetch_history_bloc.dart';
import '../bloc/filter/filter_cubit.dart';

class FilterDrawer extends StatelessWidget {
  FilterDrawer({
    super.key,
    required this.themeData,
    required this.size,
  });

  final ThemeData themeData;
  final Size size;

  // range values from filter params
  RangeValues currentRange = RangeValues(0, 50);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        var minScore = state.filterParams.minScore?.toDouble() ?? 0;
        var maxScore = state.filterParams.maxScore?.toDouble() ?? 50;
        currentRange = RangeValues(minScore, maxScore);
        return SafeArea(
          bottom: true,
          maintainBottomViewPadding: true,
          child: Drawer(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: themeData.scaffoldBackgroundColor,
            child: Column(
              children: [
                Card(
                  color: themeData.scaffoldBackgroundColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  margin: const EdgeInsets.only(bottom: 10),
                  surfaceTintColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_list_rounded),
                        const SizedBox(width: 10),
                        Text(
                          'Filter',
                          style: themeData.textTheme.bodyLarge,
                        ),
                        Spacer(),
                        if (state.filterParams != FilterParamsEntity())
                          TextButton(
                            onPressed: () {
                              context.read<FilterCubit>().clearFilter();
                            },
                            child: Text(
                              'Clear Filters',
                              style: themeData.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: themeData.colorScheme.primary,
                              ),
                            ),
                          ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                buildScoreFilterItem(context, state.filterParams),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      buildFilterItem(
                          context,
                          'Type',
                          QuizType.values.map((e) => e.value!).toList(),
                          state.filterParams),
                      buildFilterItem(
                          context,
                          'Difficulty',
                          QuizDifficulty.values.map((e) => e.value!).toList(),
                          state.filterParams),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight + 30),
                  child: CustomButton(
                    text: 'Done',
                    onPressed: () {
                      context.read<FetchHistoryBloc>().add(
                            FetchHistoryByFilter(
                              state.filterParams,
                            ),
                          );

                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFilterItem(BuildContext context, String title,
      List<String> values, FilterParamsEntity filterParams) {
    return ExpansionTile(
      title: Text(
        title,
        style: themeData.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        ...values.map(
          (value) => ListTile(
            onTap: () {
              if (title == 'Type') {
                context.read<FilterCubit>().updateFilter(
                      filterParams.copyWith(
                        type: filterParams.type.toString() == value
                            ? null
                            : value,
                      ),
                    );
              } else {
                context.read<FilterCubit>().updateFilter(
                      filterParams.copyWith(
                        difficulty: filterParams.difficulty.toString() == value
                            ? null
                            : value,
                      ),
                    );
              }
            },
            // leading: Icon(Icons.check), add check_blank
            leading: title == 'Type' && filterParams.type == value ||
                    title == 'Difficulty' && filterParams.difficulty == value
                ? Icon(Icons.check_box, color: themeData.colorScheme.secondary)
                : const Icon(
                    Icons.check_box_outline_blank,
                  ),
            title: Text(value),
          ),
        ),
      ],
    );
  }

  Widget buildScoreFilterItem(
      BuildContext context, FilterParamsEntity filterParams) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Score Range',
              style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            activeColor: themeData.colorScheme.secondary,
            inactiveColor: themeData.colorScheme.secondary.withOpacity(0.2),
            values: currentRange,
            min: 0,
            max: 50,
            // Adjust to the maximum score in your app
            divisions: 10,
            // Optional: set number of steps
            labels: RangeLabels(
              currentRange.start.round().toString(),
              currentRange.end.round().toString(),
            ),
            onChangeStart: (RangeValues values) {
              print(
                  'Start: ${values.start.round()} | End: ${values.end.round()}');
            },
            onChangeEnd: (RangeValues values) {
              print(
                  'Start: ${values.start.round()} | End: ${values.end.round()}');
            },
            onChanged: (RangeValues values) {
              currentRange = values;
              // update min and max individually
              if (values.start.round() != filterParams.minScore) {
                context.read<FilterCubit>().updateFilter(
                      filterParams.copyWith(minScore: values.start.round()),
                    );
              }
              if (values.end.round() != filterParams.maxScore) {
                context.read<FilterCubit>().updateFilter(
                      filterParams.copyWith(maxScore: values.end.round()),
                    );
              }
            },
          ),
          Text(
              'Min: ${currentRange.start.round()} | Max: ${currentRange.end.round()}'),
        ],
      ),
    );
  }
}
