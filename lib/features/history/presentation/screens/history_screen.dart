import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/history/presentation/bloc/fetch_history/fetch_history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchHistoryBloc>().add(const FetchHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: BlocBuilder<FetchHistoryBloc, FetchHistoryState>(
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
                return ListTile(
                  title: Text(history.quizTitle),
                  trailing: Text('Score: ${history.score}'),
                  subtitle: Text('Completed at: ${history.completedAt}'),
                );
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
    );
  }
}
