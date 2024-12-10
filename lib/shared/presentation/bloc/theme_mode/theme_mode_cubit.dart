import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/utils/local_storage_constants.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit(super.initialState);

  Future<void> updateTheme(ThemeMode theme) async {
    var box = Hive.box(settingsBoxKey);
    if (theme == ThemeMode.dark) {
      box.put(themeModeKey, 'dark');
    } else if (theme == ThemeMode.light) {
      box.put(themeModeKey, 'light');
    } else {
      box.put(themeModeKey, 'system');
    }
    emit(theme);
  }

  ThemeMode getTheme() {
    var box = Hive.box(settingsBoxKey);
    String? themeMode = box.get(themeModeKey);

    if (themeMode == null) {
      return ThemeMode.system;
    } else if (themeMode == 'dark') {
      return ThemeMode.dark;
    } else if(themeMode == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}