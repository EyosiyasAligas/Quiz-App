import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/history/domain/entities/filter_params_entity.dart';
import 'package:quiz_app/shared/presentation/widgets/custom_button.dart';

import '../../../../core/route/router.dart';
import '../../../../core/utils/helper.dart';
import '../../domain/entities/history_entity.dart';
import '../bloc/fetch_history/fetch_history_bloc.dart';
import '../bloc/filter/filter_cubit.dart';
import '../widgets/filter_drawer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => const HistoryScreen(),
    );
  }

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Size size;
  late ThemeData themeData;

  updateFilter(FilterParamsEntity filterParams) {
    context.read<FilterCubit>().updateFilter(filterParams);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<FetchHistoryBloc>().add(const FetchHistory());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          title: const Text('History'),
          automaticallyImplyLeading: false,
          actions: const [SizedBox.shrink()]),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<FilterCubit, FilterState>(
              listener: (context, state) {
                if (state is FilterUpdated) {
                  context.read<FetchHistoryBloc>().add(
                        FetchHistoryByFilter(
                          state.filterParams,
                        ),
                      );
                } else if (state is FilterCleared) {
                  context.read<FetchHistoryBloc>().add(const FetchHistory());
                }
              },
              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: buildFilterButton(context, state.filterParams),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 3,
                        child: buildSortByButton(),
                      ),
                      if (size.width > size.height &&
                          state.filterParams != const FilterParamsEntity())
                        Flexible(
                          flex: 2,
                          child: TextButton(
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
                        ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<FetchHistoryBloc, FetchHistoryState>(
                builder: (context, state) {
                  if (state is FetchHistoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchHistorySuccess) {
                    // state.history is empty
                    if (state.history.isEmpty) {
                      return const Center(
                        child: Text('No history found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final history = state.history[index];
                        return buildHistoryItem(history);
                      },
                    );
                  }
                  if (state is FetchHistoryFailure) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: FilterDrawer(
        themeData: themeData,
        size: size,
      ),
      // drawerDragStartBehavior: DragStartBehavior.start,
      // drawerEnableOpenDragGesture: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.delete_outline),
      ),
    );
  }

  Widget buildHistoryItem(HistoryEntity history) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          ListTile(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            tileColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.reviewScreen,
                arguments: history,
              );
            },
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                history.quizTitle,
                style: themeData.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: history.score / history.questions.length,
                  backgroundColor: Colors.grey.shade300,
                ),
                Text(
                  '${((history.score / history.questions.length) * 100).toInt()}',
                  style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              Helper.formatDate(history.completedAt),
              style: themeData.textTheme.bodySmall?.copyWith(
                color: themeData.disabledColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: themeData.disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterButton(
      BuildContext context, FilterParamsEntity filterParams) {
    int filterCount =
        filterParams.props.where((element) => element != null).length;
    return Container(
      // padding: const EdgeInsets.symmetric( vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.canvasColor,
        ),
      ),
      child: ListTile(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 21.5),
        dense: true,
        minTileHeight: 0,
        minVerticalPadding: 0,
        leading: const Icon(Icons.filter_list_rounded),
        title: Text(
          'Filter',
          style: themeData.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: filterCount != 0
            ? FittedBox(
                child: Text(
                  '( $filterCount )',
                  style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget buildSortByButton() {
    return Container(
      // margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.canvasColor,
        ),
      ),
      child: ListTile(
        onTap: () {
          // Scaffold.of(context).openEndDrawer();
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        dense: true,
        minTileHeight: 0,
        minVerticalPadding: 0,
        title: Text(
          'Sort by',
          style: themeData.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text('Completed date'),
        trailing: Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}
