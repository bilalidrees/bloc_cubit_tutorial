part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class InitialState extends HomeState {
  InitialState();
}

class LoadingState extends HomeState {
  bool? isVisible;

  LoadingState({isVisible});
}

class HomeSuccessState extends HomeState {
  bool? isSuccess;
  List<Pokemon>? pokemonList;

  HomeSuccessState({this.isSuccess, this.pokemonList});
}

class ErrorState extends HomeState {
  final String? message;

  ErrorState({this.message});
}
