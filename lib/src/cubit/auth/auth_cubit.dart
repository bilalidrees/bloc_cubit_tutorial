import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pokdex/src/cubit/utility/SessionClass.dart';
import 'package:pokdex/src/cubit/utility/SharedPrefrence.dart';
import 'package:pokdex/src/model/User.dart';
import 'package:pokdex/src/resource/repository/AuthRepository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository? _authRepository;

  AuthCubit(this._authRepository) : super(InitialState());

  signUp(String name, String email, String password, BuildContext context) {
    _startLoading();
    _authRepository!.signUp(name, email, password, context).then((value) {
      emit(AuthSuccessState(isSuccess: true));
    }, onError: (exception) {
      emit(ErrorState(message: exception.toString(), isVisible: false));
    });
  }

  signIn(String email, String password, BuildContext context) {
    _startLoading();
    _authRepository!.signIn(email, password, context).then((user) async {
      await SharedPref.createInstance().setCurrentUser(user!);
      SessionClass? sessionClass = await SessionClass.getInstance();
      sessionClass!.setCurrentUser(user);
      emit(AuthSuccessState(isSuccess: true));
    }, onError: (exception) {
      emit(ErrorState(message: exception.toString(), isVisible: false));
    });
  }

  void _startLoading() {
    emit(LoadingState(isVisible: true));
  }
}
