import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/mock_shop_repository.dart';
import 'logic/cart/cart_bloc.dart';
import 'logic/navigation/navigation_cubit.dart';
import 'logic/product/product_bloc.dart';
import 'logic/wishlist/wishlist_bloc.dart';
import 'presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF141517),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final repository = MockShopRepository();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final MockShopRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: MaterialApp(
        title: '11FIT',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const MainScreen(),
      ),
    );
  }
}
