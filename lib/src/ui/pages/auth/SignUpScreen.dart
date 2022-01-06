import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokdex/src/AppLocalizations.dart';
import 'package:pokdex/src/cubit/auth/auth_cubit.dart';
import 'package:pokdex/src/cubit/utility/AppConfig.dart';
import 'package:pokdex/src/cubit/utility/FirebaseRef.dart';
import 'package:pokdex/src/cubit/utility/Validations.dart';
import 'package:pokdex/src/ui/ui_constant/ImageAssetsResolver.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';
import 'package:pokdex/src/ui/widgets/BackgroundImage.dart';
import 'package:pokdex/src/ui/widgets/CustomButton.dart';
import 'package:pokdex/src/ui/widgets/CustomOverFlowWidget.dart';
import 'package:pokdex/src/ui/widgets/CustomTextField.dart';
import 'package:toast/toast.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true, isConfirmPasswordHidden = true;
  File? _image;
  String? imageUrl;
  FirebaseUser? user;

  setPasswordStatus(bool isPassword) {
    setState(() {
      if (isPassword)
        isPasswordHidden = !isPasswordHidden;
      else
        isConfirmPasswordHidden = !isConfirmPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Toast.show(
              AppLocalizations.of(context)!
                  .translate(Strings.REGISTER_SUCCESFULLY),
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
          Navigator.pop(context);
        }
        if (state is ErrorState) {
          Toast.show("${state.message}", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is LoadingState ? true : false,
          child: Stack(
            children: [
              BackgroundImage(image: ImageAssetsResolver.APP_BG),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomOverFlowWidget(
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppConfig.of(context).appWidth(13),
                      ),
                      SizedBox(
                        height: AppConfig.of(context).appWidth(5),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              AppLocalizations.of(context)!
                                  .translate(Strings.USER_NAME),
                              TextInputType.text,
                              VALIDATION_TYPE.NAME,
                              Icons.account_circle,
                              nameController,
                              false,
                              () {},
                              isAppColorEnable: false,
                              width: AppConfig.of(context).appWidth(80),
                              isEnabled: false,
                              onKeyPressed: () {},
                            ),
                            SizedBox(height: AppConfig.of(context).appWidth(5)),
                            CustomTextField(
                              AppLocalizations.of(context)!
                                  .translate(Strings.EMAIL),
                              TextInputType.emailAddress,
                              VALIDATION_TYPE.EMAIL,
                              Icons.alternate_email,
                              emailController,
                              false,
                              () {},
                              isAppColorEnable: false,
                              width: AppConfig.of(context).appWidth(80),
                              onKeyPressed: () {},
                              isEnabled: false,
                            ),
                            SizedBox(height: AppConfig.of(context).appWidth(5)),
                            CustomTextField(

                              AppLocalizations.of(context)!
                                  .translate(Strings.PASSWORD),
                              TextInputType.visiblePassword,
                              VALIDATION_TYPE.PASSWORD,
                              Icons.lock,
                              passwordController,
                              isPasswordHidden,
                              () {
                                setPasswordStatus(true);
                              },
                              isAppColorEnable: false,
                              width: AppConfig.of(context).appWidth(80),
                              onKeyPressed: () {},
                              isEnabled: false,
                            ),
                            SizedBox(height: AppConfig.of(context).appWidth(5)),
                            CustomTextField(
                              AppLocalizations.of(context)!
                                  .translate(Strings.CONFIRM_PASSWORD),
                              TextInputType.visiblePassword,
                              VALIDATION_TYPE.PASSWORD,
                              Icons.lock,
                              confirmPasswordController,
                              isConfirmPasswordHidden,
                              () {
                                setPasswordStatus(false);
                              },
                              isAppColorEnable: false,
                              width: AppConfig.of(context).appWidth(80),
                              isEnabled: false,
                              onKeyPressed: () {},
                            ),
                            SizedBox(
                                height: AppConfig.of(context).appWidth(10)),
                            if (state is LoadingState)
                              Center(child: CircularProgressIndicator()),
                            if (state is LoadingState)
                              SizedBox(
                                height: AppConfig.of(context).appWidth(5),
                              ),
                            CustomButton(
                              onPressed: () async {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).signUp(
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        context);
                                  }
                                } else {
                                  Toast.show(
                                      AppLocalizations.of(context)!.translate(
                                          Strings.CONFIRM_PASSWORD_MATCH),
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              },
                              radius: 10,
                              text: AppLocalizations.of(context)!
                                  .translate(Strings.REGISTER),
                              textColor: Colors.white,
                              backgorundColor:
                                  AppColors.of(context).mainColor(1),
                              width: AppConfig.of(context).appWidth(80),
                              isToShowEndingIcon: false,
                            ),
                            SizedBox(
                                height: AppConfig.of(context).appWidth(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.translate(
                                      Strings.ALREADY_HAVE_AN_ACCOUNT)!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          fontSize: AppConfig.of(context)
                                              .appWidth(5)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate(Strings.LOGIN)!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: AppColors.of(context)
                                                .mainColor(1),
                                            fontSize: AppConfig.of(context)
                                                .appWidth(5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: AppConfig.of(context).appWidth(10)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
