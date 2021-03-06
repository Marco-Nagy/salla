import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/modules/authentecation/login_screen.dart';
import 'package:salla_shop_app/modules/shop_layout.dart';

import '../../Components.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Lottie.network(
          'https://assets8.lottiefiles.com/packages/lf20_929ihyjs.json',
          controller: _controller,
          height: MediaQuery.of(context).size.height * 1,
          animate: true,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(() =>
                  navigate()
                  //navigateTo(context, LoginScreen())
                  );
          },
        ));
  }

  void navigate() {

    if (MyShared.getData('token') == null) {
      navigateTo(context, LoginScreen());
    } else {
      print('token >> '+MyShared.getData('token').toString());
      navigateTo(context, ShopLayout());
    }
  }
}
