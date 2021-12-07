import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/models/login_response.dart';


abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginResponse loginResponse;

 LoginSuccessState(this.loginResponse);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginPasswordVisibilityState extends LoginStates {}

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginResponse loginResponse;


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endpoint: LOGIN,
      body: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
       loginResponse = LoginResponse.fromJson(value.data);
      emit(LoginSuccessState(loginResponse));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;

  bool passwordVisible = true;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }
}
