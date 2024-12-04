import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/fetch_question/fetch_question_bloc.dart';

import '../../../../shared/service_locator.dart';
import '../bloc/choose_preference/choose_preference_cubit.dart';
import '../bloc/fetch_category/fetch_category_bloc.dart';
import '../widgets/choose_preference_container.dart';
import '../widgets/custom_navigation_bar.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<FetchCategoryBloc>(
            create: (context) => sl<FetchCategoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ChoosePreferenceCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<FetchQuestionBloc>(),
          ),
        ],
        child: const PreferenceScreen(),
      ),
    );
  }

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchCategoryBloc>().add(const FetchCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Preferences'),
      ),
      body: BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
        builder: (context, state) {
          if (state is FetchCategoryLoadInProgress) {
            return Center(
              child: Lottie.asset(
                'assets/json/loading.json',
                frameRate: FrameRate.max,
                fit: BoxFit.cover,
              ),
            );
          } else if (state is FetchCategoryLoadSuccess) {
            return ChoosePreferenceContainer(categoryItems: state.categories);
          } else if (state is FetchCategoryLoadFailure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
