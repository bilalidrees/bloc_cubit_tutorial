import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokdex/src/AppLocalizations.dart';
import 'package:pokdex/src/cubit/auth/auth_cubit.dart';
import 'package:pokdex/src/cubit/home/home_cubit.dart';
import 'package:pokdex/src/cubit/utility/Validations.dart';
import 'package:pokdex/src/resource/repository/AuthRepository.dart';
import 'package:pokdex/src/resource/repository/HomeRepository.dart';
import 'package:pokdex/src/ui/pages/auth/LoginScreen.dart';
import 'package:pokdex/src/ui/pages/auth/SignUpScreen.dart';
import 'package:pokdex/src/ui/pages/main/Home.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';
import 'src/ui/pages/main/MainPageNavigator.dart';
import 'src/ui/pages/main/SplashScreen.dart';
import 'src/app.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.arguments != null)
      final ScreenArguments args = settings.arguments as ScreenArguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget("/", child: SplashScreen()));
      case RouteNames.LOGIN:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(AuthRepository()),
                  child:
                      RouteAwareWidget(RouteNames.LOGIN, child: LoginScreen()),
                ));
      case RouteNames.SIGN_UP:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteNames.SIGN_UP,
                child: BlocProvider(
                  create: (context) => AuthCubit(AuthRepository()),
                  child: SignUpScreen(),
                )));
      case RouteNames.HOME_SCREEN:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteNames.HOME_SCREEN,
                child: BlocProvider(
                  create: (context) => HomeCubit(HomeRepository()),
                  child: HomeScreen(),
                )));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(buildContext!)!.translate(Strings.ERROR)!),
        ),
        body: Center(
          child: Text(
              AppLocalizations.of(buildContext!)!.translate(Strings.ERROR)!),
        ),
      );
    });
  }
}

class RouteNames {
  static const String SPLASH = "/welcome";
  static const String MAINPAGE = "/MainPage";
  static const String LOGIN = "/Login";
  static const String SIGN_UP = "/SIGNUP";
  static const String HOME_SCREEN = "/HOME_SCREEN";
}
