import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/helper.dart';
import '../../../../shared/presentation/widgets/error_container.dart';
import '../bloc/fetch_category/fetch_category_bloc.dart';
import '../widgets/choose_preference_container.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => const PreferenceScreen(),
    );
  }

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  bool isInternetConnected = true;
  late Size size;
  late ThemeData themeData;

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
        key: const Key('appBar'),
        title: const Text('Quiz Preferences'),
      ),
      body: StreamBuilder<bool>(
          stream: Helper.checkInternetConnectivity(),
          builder: (context, snapshot) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  width: size.width,
                  child: snapshot.data == false
                      ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          color:
                              themeData.colorScheme.secondary.withOpacity(0.3),
                          child: Text(
                            'No Internet Connection',
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: themeData.disabledColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
                  key: const Key('fetchCategoryBloc'),
                  builder: (context, state) {
                    if (state is FetchCategoryLoadInProgress) {
                      return Center(
                        key: const Key('loading'),
                        child: Lottie.asset(
                          'assets/json/loading.json',
                          frameRate: FrameRate.max,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else if (state is FetchCategoryLoadSuccess) {
                      return ChoosePreferenceContainer(
                        key: const Key('success'),
                        categoryItems: state.categories,
                      );
                    } else if (state is FetchCategoryLoadFailure) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: ErrorContainer(
                          key: const Key('error'),
                          errorMessageText: state.message,
                          showRetryButton: true,
                          onTapRetry: () {
                            context
                                .read<FetchCategoryBloc>()
                                .add(const FetchCategory());
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            );
          }),
    );
  }
}
