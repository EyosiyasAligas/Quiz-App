import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/core/utils/theme_mode_cubit.dart';

import 'core/route/router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/helper.dart';
import 'core/utils/local_storage_constants.dart';
import 'features/quiz/presentation/bloc/fetch_question/fetch_question_bloc.dart';
import 'features/quiz/presentation/screens/quiz_screen.dart';
import 'shared/service_locator.dart';

Future<void> main() async {
  await initAppInjections();

  await Hive.initFlutter();
  await Hive.openBox(settingsKey);
  await Hive.openBox(themeModeKey);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchQuestionBloc>(
          create: (context) => sl<FetchQuestionBloc>(),
        ),
        BlocProvider(create: (context) => sl<ThemeModeCubit>()),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) {
          var currentTheme = context.read<ThemeModeCubit>().getTheme();
          return ScreenUtilInit(
            designSize: Size(MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Quiz App',
                theme: appTheme,
                darkTheme: darkAppTheme,
                themeMode: currentTheme,
                onGenerateRoute: Routes.onGenerateRouted,
                initialRoute: Routes.splash,
              );
            },
          );
        },
      ),
    );
  }
}
