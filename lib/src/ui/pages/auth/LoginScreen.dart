import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokdex/src/cubit/auth/auth_cubit.dart';
import 'package:pokdex/src/AppLocalizations.dart';
import 'package:pokdex/src/cubit/utility/AppConfig.dart';
import 'package:pokdex/src/cubit/utility/Validations.dart';
import 'package:pokdex/src/ui/ui_constant/ImageAssetsResolver.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';
import 'package:pokdex/src/ui/widgets/BackgroundImage.dart';
import 'package:pokdex/src/ui/widgets/CustomButton.dart';
import 'package:pokdex/src/ui/widgets/CustomOverFlowWidget.dart';
import 'package:pokdex/src/ui/widgets/CustomTextField.dart';
import 'package:toast/toast.dart';
import '../../../../route_generator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isToShowLoginDialog = false, isPasswordHidden = true;
  final _formKey = GlobalKey<FormBuilderState>();

  setPasswordStatus() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Toast.show(
              AppLocalizations.of(context)!
                  .translate(Strings.LOGIN_SUCCESFULLY)!,
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
          Future.delayed(Duration(seconds: 1)).then((value) {
            Navigator.of(context).pushReplacementNamed(RouteNames.HOME_SCREEN);
          });
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
              BackgroundImage(
                image: ImageAssetsResolver.APP_BG,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomOverFlowWidget(
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context!)!
                                  .translate(Strings.APP_NAME)!,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  AppLocalizations.of(context)!
                                      .translate(Strings.EMAIL),
                                  TextInputType.text,
                                  VALIDATION_TYPE.EMAIL,
                                  Icons.account_circle,
                                  emailController,
                                  false,
                                  () {},
                                  isAppColorEnable: false,
                                  width: AppConfig.of(context).appWidth(80),
                                  onKeyPressed: () {},
                                  isEnabled: false,
                                ),
                                SizedBox(
                                  height: AppConfig.of(context).appWidth(5),
                                ),
                                CustomTextField(
                                  AppLocalizations.of(context)!
                                      .translate(Strings.PASSWORD),
                                  TextInputType.visiblePassword,
                                  VALIDATION_TYPE.PASSWORD,
                                  Icons.lock,
                                  passwordController,
                                  isPasswordHidden,
                                  () {
                                    setPasswordStatus();
                                  },
                                  isAppColorEnable: false,
                                  width: AppConfig.of(context).appWidth(80),
                                  onKeyPressed: () {},
                                  isEnabled: false,
                                ),
                                SizedBox(
                                  height: AppConfig.of(context).appWidth(5),
                                ),
                                if (state is LoadingState)
                                  Center(child: CircularProgressIndicator()),
                                if (state is LoadingState)
                                  SizedBox(
                                    height: AppConfig.of(context).appWidth(5),
                                  ),
                                SizedBox(
                                  height: AppConfig.of(context).appWidth(3),
                                ),
                                CustomButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .signIn(emailController.text,
                                              passwordController.text, context);
                                    }
                                  },
                                  radius: 10,
                                  text: AppLocalizations.of(context)!
                                      .translate(Strings.LOG_IN),
                                  textColor: Colors.white,
                                  backgorundColor:
                                      AppColors.of(context).mainColor(1),
                                  width: AppConfig.of(context).appWidth(80),
                                  isToShowEndingIcon: false,
                                ),
                                SizedBox(
                                  height: AppConfig.of(context).appWidth(20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed(RouteNames.SIGN_UP),
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate(Strings.CREATE_NEW_ACCOUNT)!,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize:
                                        AppConfig.of(context).appWidth(5)),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white))),
                        ),
                      ),
                      SizedBox(
                        height: AppConfig.of(context).appWidth(10),
                      ),
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
