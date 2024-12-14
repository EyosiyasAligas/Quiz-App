import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/core/utils/helper.dart';
import 'package:quiz_app/features/quiz/presentation/screens/preference_screen.dart';

import '../../../../shared/service_locator.dart';
import '../../../history/presentation/screens/history_screen.dart';
import '../bloc/navigation/navigation_cubit.dart';
import '../widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => sl<NavigationCubit>(),
        child: const HomeScreen(),
      ),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late ThemeData themeData;
  late TabController _tabController;

  final _screens = const [
    PreferenceScreen(),
    HistoryScreen(),
    Scaffold(
      body: Center(
        child: Text('Settings'),
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    themeData = Theme.of(context);
    _tabController.addListener(() {
      context.read<NavigationCubit>().changeIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {
        if (state is NavigationChanged) {
          _tabController.animateTo(
            state.index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Container(
            height: ScreenUtil().screenHeight,
            child: StreamBuilder<bool>(
                stream: Helper.checkInternetConnectivity(),
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      TabBarView(
                        controller: _tabController,
                        children: _screens,
                      ),
                      Positioned(
                        top: 80,
                        height: 40,
                        width: ScreenUtil().screenWidth,
                        child: snapshot.data == false
                            ? Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                color: themeData.colorScheme.secondary
                                    .withOpacity(0.3),
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
                    ],
                  );
                }),
          ),
          bottomNavigationBar: Container(
            padding: ScreenUtil().screenWidth > ScreenUtil().screenHeight ? const EdgeInsets.symmetric(horizontal: 100) : null,
            child: CustomNavigationBar(
              height: 60,
              selectedIndex: state is NavigationChanged ? state.index : 0,
              iconSize: 24,
              shadowColor: themeData.colorScheme.primary,
              surfaceTintColor: themeData.colorScheme.primary.withOpacity(0.9),
              selectedIconColor: themeData.colorScheme.onSecondary,
              indicatorColor: themeData.colorScheme.secondary.withOpacity(0.5),
              onDestinationSelected: (index) {
                context.read<NavigationCubit>().changeIndex(index);
              },
              icons: const [
                Icons.home_filled,
                Icons.history,
                Icons.settings_rounded,
              ],
              labels: const [
                'Home',
                'Settings',
                'Profile',
              ],
            ),
          ),
        );
      },
    );
  }
}
