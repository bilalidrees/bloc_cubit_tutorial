import 'package:pokdex/src/cubit/utility/AppConfig.dart';
import 'package:pokdex/src/cubit/utility/SessionClass.dart';
import 'package:pokdex/src/cubit/utility/SharedPrefrence.dart';
import 'package:pokdex/src/model/User.dart';
import 'package:pokdex/src/ui/ui_constant/ImageAssetsResolver.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';
import '../../../../../route_generator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      await SessionClass.getInstance();
      navigateToMainScreen();
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: AppColors.appScreenColor,
            child: Image.asset(
              ImageAssetsResolver.APP_BG,
              height: AppConfig.of(context).appHeight(100),
              width: AppConfig.of(context).appHeight(100),
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  void navigateToMainScreen() async {
    User? user = await SharedPref.createInstance().getCurrentUser();
    if (user != null) {
      SessionClass? sessionClass = await SessionClass.getInstance();
      sessionClass!.setCurrentUser(user);
      Navigator.of(context).pushReplacementNamed(RouteNames.HOME_SCREEN);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.LOGIN);
    }
  }
}
