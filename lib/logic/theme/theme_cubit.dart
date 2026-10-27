import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  // Default to light theme as requested by user ("i want white so give a option to change theme")
  ThemeCubit({ThemeMode initialMode = ThemeMode.light}) : super(initialMode);

  void toggleTheme() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
  }
}
