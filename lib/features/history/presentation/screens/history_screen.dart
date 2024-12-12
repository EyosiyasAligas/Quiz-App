import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/core/theme/app_colors.dart';

import '../../../../core/route/router.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/local_storage_constants.dart';
import '../../domain/entities/history_entity.dart';
import '../bloc/fetch_history/fetch_history_bloc.dart';

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
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
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
                  return buildHistoryItem(state.history[index]);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //delete all history from cache
          final box = Hive.box(historyBoxKey);
          box.delete(historyKey);
        },
        child: const Icon(Icons.delete_outline),
      ),
    );
  }

  Widget buildHistoryItem(HistoryEntity history) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 2,
        color: themeData.cardColor,
        shadowColor: themeData.colorScheme.primary,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.reviewScreen,
              arguments: history,
            );
          },
          title: Text(
            history.quizTitle,
            style: themeData.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
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
          subtitle: Text(Helper.formatDate(history.completedAt)),
        ),
      ),
    );
  }
}
