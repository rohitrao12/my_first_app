import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/mock_shop_repository.dart';
import 'logic/cart/cart_bloc.dart';
import 'logic/navigation/navigation_cubit.dart';
import 'logic/product/product_bloc.dart';
import 'logic/theme/theme_cubit.dart';
import 'logic/wishlist/wishlist_bloc.dart';
import 'presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = MockShopRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final MockShopRepository repository;
  final ThemeMode initialThemeMode;

  const MyApp({
    super.key,
    required this.repository,
    this.initialThemeMode = ThemeMode.light, // Default to light/white theme per user request
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(initialMode: initialThemeMode),
        ),
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(repository: repository),
        ),
        BlocProvider<WishlistBloc>(
          create: (_) => WishlistBloc(repository: repository),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(repository: repository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final isDark = themeMode == ThemeMode.dark;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              systemNavigationBarColor:
                  isDark ? const Color(0xFF141517) : Colors.white,
              systemNavigationBarIconBrightness:
                  isDark ? Brightness.light : Brightness.dark,
            ),
          );

          return MaterialApp(
            title: '11FIT',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
