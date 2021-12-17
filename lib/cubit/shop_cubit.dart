import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/models/category_response.dart';
import 'package:salla_shop_app/models/favorite_change_response.dart';
import 'package:salla_shop_app/models/favorite_get_response.dart';
import 'package:salla_shop_app/models/home_response.dart';
import 'package:salla_shop_app/models/login_response.dart';
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

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  FavoriteChangeResponse favoriteChangeResponse;

  ShopSuccessChangeFavoritesState(this.favoriteChangeResponse);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {
  LoginResponse userResponse;

  ShopSuccessGetProfileState(this.userResponse);
}

class ShopErrorGetProfileState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {
  LoginResponse userResponse;

  ShopSuccessUpdateProfileState(this.userResponse);
}

class ShopErrorUpdateProfileState extends ShopStates {}

class ShopLoadingUpdateProfileState extends ShopStates {}
class UpdatePasswordVisibilityState extends ShopStates {}


// class SearchLoadingState extends ShopStates {}
//
// class SearchSuccessState extends ShopStates {
//   SearchResponse searchResponse;
//
//   SearchSuccessState(this.searchResponse);
// }
//
// class SearchErrorState extends ShopStates {
//   final String error;
//
//   SearchErrorState(this.error);
// }

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
  HomeResponse? homeResponse;

  Map<int?, bool?>? favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      endPoint: HOME,
      token: token,
    ).then((value) {
      homeResponse = HomeResponse.fromJson(value.data);
      print(value);
      homeResponse!.data!.products!.forEach((element) {
        favorites!.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoryResponse? categoriesResponse;

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

  late FavoriteChangeResponse favoriteChangeResponse;

  void changeFavorites(int productId) {
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      endpoint: FAVORITES,
      body: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoriteChangeResponse = FavoriteChangeResponse.fromJson(value.data);
      print(value);
      if (!favoriteChangeResponse.status!) {
        favorites![productId] = !favorites![productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(favoriteChangeResponse));
    }).catchError((onError) {
      favorites![productId] = !favorites![productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoriteGetResponse? favoritesGetResponse;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      endPoint: FAVORITES,
      token: token,
    ).then((value) {
      favoritesGetResponse = FavoriteGetResponse.fromJson(value.data);
      print(value.data!);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((onError) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginResponse? userResponse;

  void getUserData() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      endPoint: PROFILE,
      token: token,
    ).then((value) {
      userResponse = LoginResponse.fromJson(value.data);
      print(value.data!);
      emit(ShopSuccessGetProfileState(userResponse!));
    }).catchError((onError) {
      emit(ShopErrorGetProfileState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
    String? password,

  }) {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      endpoint: UPDATE_PROFILE,
      token: token,
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      userResponse = LoginResponse.fromJson(value.data);
      print(value.data!);
      emit(ShopSuccessUpdateProfileState(userResponse!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUpdateProfileState());
    });
  }
  IconData suffix = Icons.visibility_off_outlined;

  bool passwordVisible = true;

  void changeRegisterPasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(UpdatePasswordVisibilityState());
  }
  // SearchResponse? searchResponse;
  // void search(String text) {
  //   emit(SearchLoadingState());
  //   DioHelper.postData(
  //     endpoint: SEARCH,
  //     body: {
  //       'text':text,
  //     },
  //     token: token,
  //   ).then((value){
  //     print(value);
  //     emit(SearchSuccessState(searchResponse!));
  //   }).catchError((error){
  //     print(onError);
  //     emit(SearchErrorState(error.toString()));
  //   });
  // }

}
