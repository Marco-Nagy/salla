import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/models/login_response.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginResponse registerResponse;

  RegisterSuccessState(this.registerResponse);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterStates {}

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginResponse registerResponse;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,

  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      endpoint: REGISTER,
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,

      },
    ).then((value) {
      print(value.data);
      registerResponse = LoginResponse.fromJson(value.data);
      emit(RegisterSuccessState(registerResponse));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;

  bool passwordVisible = true;

  void changeRegisterPasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffix = passwordVisible
        ? Icons.visibility_off_outlined
        :Icons.visibility_outlined ;
    emit(RegisterPasswordVisibilityState());
  }
}
