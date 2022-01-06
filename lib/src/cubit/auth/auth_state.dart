part of 'auth_cubit.dart';

abstract class AuthState {}

class InitialState extends AuthState {
  InitialState();
}

class LoadingState extends AuthState {
  bool? isVisible;

  LoadingState({isVisible});
}

class AuthSuccessState extends AuthState {
  bool? isSuccess;
  User? user;

  AuthSuccessState({this.user, this.isSuccess});
}

class ErrorState extends AuthState {
  final String? message;
  bool? isVisible;

  ErrorState({this.message, this.isVisible});
}

class SignOutSuccessState extends AuthState {}
