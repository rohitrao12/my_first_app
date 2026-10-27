import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/logic/theme/theme_cubit.dart';

void main() {
  group('ThemeCubit Tests', () {
    test('Initial theme defaults to ThemeMode.light (White theme)', () {
      final themeCubit = ThemeCubit();
      expect(themeCubit.state, ThemeMode.light);
      themeCubit.close();
    });

    test('toggleTheme toggles between light and dark modes', () {
      final themeCubit = ThemeCubit(initialMode: ThemeMode.light);

      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.dark);

      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.light);

      themeCubit.close();
    });

    test('setTheme sets specific ThemeMode', () {
      final themeCubit = ThemeCubit();

      themeCubit.setTheme(ThemeMode.dark);
      expect(themeCubit.state, ThemeMode.dark);

      themeCubit.setTheme(ThemeMode.light);
      expect(themeCubit.state, ThemeMode.light);

      themeCubit.close();
    });
  });
}
