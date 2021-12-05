import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/models/category_response.dart';
import 'package:salla_shop_app/models/home_response.dart';
import 'package:salla_shop_app/modules/categories_screen.dart';
import 'package:salla_shop_app/modules/favorites_screen.dart';
import 'package:salla_shop_app/modules/home_screen.dart';
import 'package:salla_shop_app/modules/settings_screen.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBottomNavigateState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}
class ShopLoadingHomeCategoriesState extends ShopStates {}

class ShopSuccessHomeCategoriesState extends ShopStates {}

class ShopErrorHomeCategoriesState extends ShopStates {}

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


  String token = MyShared.getData('token');
  HomeResponse? homeResponse ;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      endPoint: HOME,
      token: token,
    ).then((value) {
      homeResponse = HomeResponse.fromJson(value.data);
      print(value);
      //print(homeResponse!.status.toString());
      // print(homeResponse!.data!.products![0].image.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoryResponse? categoriesResponse;
  void getCategoriesData() {
    emit(ShopLoadingHomeCategoriesState());
    DioHelper.getData(
      endPoint: CATEGORIES,
    ).then((value) {
      categoriesResponse = CategoryResponse.fromJson(value.data);

      print(value);
      //print(homeResponse!.status.toString());
      // print(homeResponse!.data!.products![0].image.toString());
      emit(ShopSuccessHomeCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeCategoriesState());
    });
  }


}
