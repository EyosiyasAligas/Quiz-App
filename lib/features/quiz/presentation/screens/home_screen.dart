import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/theme/app_theme.dart';
import 'package:quiz_app/core/utils/theme_mode_cubit.dart';

import '../../../../core/route/router.dart';
import '../../../../core/utils/helper.dart';
import '../../../../shared/service_locator.dart';
import '../bloc/fetch_category/fetch_category_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => sl.get<FetchCategoryBloc>(),
        child: const HomeScreen(),
      ),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
        title: const Text('Home Screen'),
      ),
      body: BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
        builder: (context, state) {
          if (state is FetchCategoryLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchCategoryLoadSuccess) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ListTile(
                  leading: Text(category.id.toString()),
                  title: Text(category.name),
                  onTap: () {},
                );
              },
            );
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
