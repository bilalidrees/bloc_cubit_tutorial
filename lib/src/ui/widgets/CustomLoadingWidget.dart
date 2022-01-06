import 'package:flutter/material.dart';
import 'package:pokdex/src/cubit/utility/AppConfig.dart';
import 'package:pokdex/src/ui/ui_constant/ImageAssetsResolver.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';

class CustomLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              color: AppColors.appScreenColor,
              child: Image.asset(
                ImageAssetsResolver.SPLASH_GIF,
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
