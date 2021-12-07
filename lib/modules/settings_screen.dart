import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/modules/authentecation/login_screen.dart';
import 'package:salla_shop_app/modules/shop_layout.dart';

import '../Components.dart';

class SettingsScreen extends StatelessWidget {

   const SettingsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserData();
    var cubit = ShopCubit.get(context).userResponse;

    var emailController = TextEditingController();
    var userNameController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var formKye = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        emailController.text = cubit!.data!.email!;
        userNameController.text = cubit.data!.name!;
        phoneNumberController.text = cubit.data!.phone!;
        return ConditionalBuilder(
          condition:  ShopCubit.get(context).userResponse != null,
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
                        inputAction: TextInputAction.next
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        controller: userNameController,
                        type: TextInputType.text,
                        validator: (value) => userNameValidator(value),
                        label: "User Name",
                        prefixIcon: Icons.person_rounded,
                        inputAction: TextInputAction.next
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        controller: phoneNumberController,
                        type: TextInputType.phone,
                        validator: (value) => phoneValidator(value),
                        label: "Phone No",
                        prefixIcon: Icons.phone,
                        inputAction: TextInputAction.next
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    defaultButton(
                      text: "UPDATE",
                      function: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                      text: "LOGOUT",
                      function: () {
                        MyShared.clearData('token').then((value) =>
                            navigateTo(context, LoginScreen())
                        );
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
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }
  userNameValidator(String? value) {
    if (value!.isEmpty) {
      return "please Enter User Name";
    }
    return null;
  }
}
