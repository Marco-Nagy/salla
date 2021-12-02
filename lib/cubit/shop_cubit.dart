import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/shop_states.dart';
import 'package:salla_shop_app/modules/categories_screen.dart';
import 'package:salla_shop_app/modules/favorites_screen.dart';
import 'package:salla_shop_app/modules/home_screen.dart';
import 'package:salla_shop_app/modules/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(ShopStates initialState) : super(initialState);

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: "Home",
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps_rounded), label: "Categories"),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined), label: "Settings"),
  ];

  void changeBottomNavigationBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavigateState());
  }

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];


}
