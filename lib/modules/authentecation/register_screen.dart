
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla_shop_app/modules/shop_layout.dart';

import '../../Components.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKye = GlobalKey<FormState>();
  bool _passwordVisible = true  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Register now to brows our hot offers",
                    style: TextStyle  (
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
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
                  defaultTextField(
                    controller: passwordController,
                    type: TextInputType.text,
                    obscureText: _passwordVisible,
                    validator: (value) => passwordValidator(value),
                    label: "password",
                    prefixIcon: Icons.lock_rounded,
                    suffixIcon:IconButton(onPressed: () {
                      _passwordVisible = !_passwordVisible;
                      setState(() {
                      });
                    }, icon: Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultTextField(
                    controller: confirmPasswordController,
                    type: TextInputType.text,
                    obscureText: _passwordVisible,
                    validator: (value) => confirmPasswordValidator(value),
                    label: "Confirm Password",
                    prefixIcon: Icons.lock_rounded,
                    suffixIcon:IconButton(onPressed: () {
                      _passwordVisible = !_passwordVisible;
                      setState(() {
                      });
                    }, icon: Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    text: "Create Account",
                    function: () {
                      if(formKye.currentState!.validate()){
                        navigateTo(context, ShopLayout());
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account?",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
  passwordValidator(value) {
    if (value!.isEmpty) {
      return "please Enter Password";
    }
    if (value.length < 8) {
      return " password must be  more 8 characters ";
    }
    bool passwordValid = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value);
    if (!passwordValid) {
      return "password not valid";
    }
    return null;
  }
  confirmPasswordValidator(value) {
    if (value!.isEmpty) {
      return "please Confirm Password";
    }
    if (passwordController.text!= confirmPasswordController.text) {
      return " password not matched ";
    }
    return null;
  }
}
