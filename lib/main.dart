import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salla_shop_app/cubit/register_cubit.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/modules/authentecation/login_screen.dart';
import 'package:salla_shop_app/modules/boarding/on_boarding_screen.dart';
import 'package:salla_shop_app/syles/themes.dart';
import 'cubit/app_cubit.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/login_cubit.dart';
import 'cubit/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await MyShared.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit(ShopInitialState()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
