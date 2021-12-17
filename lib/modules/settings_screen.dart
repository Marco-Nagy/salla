import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/modules/authentecation/login_screen.dart';
import '../Components.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var formKye = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserData();
    var cubit = ShopCubit.get(context).userResponse;


    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateProfileState) {
          if (state.userResponse.status == true) {

            print(state.userResponse.message);
            print(state.userResponse.data!.token);
            print(state.userResponse.data!);

            showToast(message: state.userResponse.message.toString());
          }
        }
        else if(state is ShopSuccessGetProfileState){
          emailController.text = cubit!.data!.email!;
          userNameController.text = cubit.data!.name!;
          phoneNumberController.text = cubit.data!.phone!;
        }
      },
      builder: (context, state) {


        return ConditionalBuilder(
          condition: state is ShopSuccessGetProfileState,
          builder: (context) => Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Form(
              key: formKye,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is ShopLoadingUpdateProfileState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "EDIT PROFILE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) => emailValidator(value),
                        label: "Email Address",
                        prefixIcon: Icons.mail,
                        inputAction: TextInputAction.next),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        controller: userNameController,
                        type: TextInputType.text,
                        validator: (value) => userNameValidator(value),
                        label: "User Name",
                        prefixIcon: Icons.person_rounded,
                        inputAction: TextInputAction.next),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        controller: phoneNumberController,
                        type: TextInputType.phone,
                        validator: (value) => phoneValidator(value),
                        label: "Phone No",
                        prefixIcon: Icons.phone,
                        inputAction: TextInputAction.next),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      controller: passwordController,
                      type: TextInputType.text,
                      obscureText:  ShopCubit.get(context).passwordVisible,
                      validator: (value) => passwordValidator(value),
                      label: "password",
                      prefixIcon: Icons.lock_rounded,
                      suffixIcon: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeRegisterPasswordVisibility();
                        },
                        icon: Icon(ShopCubit.get(context).suffix),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                      text: "UPDATE",
                      function: () {
                        if (formKye.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: userNameController.text,
                            phone: phoneNumberController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                      text: "LOGOUT",
                      function: () {
                        MyShared.clearData('token').then(
                            (value) => navigateTo(context, LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  emailValidator(String? value) {
    if (value!.isEmpty) {
      return "please Enter Email";
    }
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
    if (!emailValid) {
      return "email not valid";
    }
    return null;
  }

  phoneValidator(String? value) {
    if (value!.isEmpty) {
      return "please Enter Phone Number";
    }
    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }

  userNameValidator(String? value) {
    if (value!.isEmpty) {
      return "please Enter User Name";
    }
    return null;
  }

  passwordValidator(value) {
    if (value!.isEmpty) {
      return "please Enter Email";
    }
    if (value.length < 8) {
      return " password must be  more 8 characters ";
    }
    bool passwordValid =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value);
    if (!passwordValid) {
      return "password not valid";
    }
    return null;
  }

}
