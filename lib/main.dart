import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_screen.dart';
import 'package:shop_app/modules/login_module/login_module.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/themes.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      var login = CacheHelper.getData(key: 'Login') ?? false;
      token = CacheHelper.getData(key: 'token') ?? '';
      print(token);
      runApp(MyApp(login));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.isLogged, {Key? key}) : super(key: key);
  final bool isLogged;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getHomeProducts()
        ..getFavoriteProducts()
        ..getCategories()
        ..getCartData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: isLogged ? const ShopLayout() : LoginScreen(),
      ),
    );
  }
}
