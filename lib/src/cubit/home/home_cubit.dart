import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pokdex/src/cubit/utility/SessionClass.dart';
import 'package:pokdex/src/cubit/utility/SharedPrefrence.dart';
import 'package:pokdex/src/model/Pokemon.dart';
import 'package:pokdex/src/model/User.dart';
import 'package:pokdex/src/resource/repository/HomeRepository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository? _homeRepository;
  List<Pokemon>? pokemonList, userFavPokemonList;

  HomeCubit(this._homeRepository) : super(LoadingState());

  void fetchPokemons() async {
    SessionClass? sessionClass = await SessionClass.getInstance();
    User? user = sessionClass!.getCurrentUser();
    userFavPokemonList =
        await SharedPref.createInstance().getFavPokemon(user: user!);
    await _homeRepository!.fetchPokemons().then((pokemon) async {
      if (userFavPokemonList!.length != 0) {
        pokemon!.forEach((pokemon) {
          pokemon.isFav = false;
          for (int index = 0; index < userFavPokemonList!.length; index++) {
            if (pokemon == userFavPokemonList![index]) {
              pokemon.isFav = true;
              break;
            }
          }
        });
      }
      pokemonList = pokemon;
      emit(HomeSuccessState(isSuccess: true, pokemonList: pokemon));
    }, onError: (exception) {
      emit(ErrorState(message: exception.toString()));
    });
  }

  void changeFavState(int index, bool status) {
    pokemonList![index].isFav = status;
    updateFavePokemon(status, pokemonList![index]);
  }

  void updateFavePokemon(bool status, Pokemon pokemon) async {
    SessionClass? sessionClass = await SessionClass.getInstance();
    User? user = sessionClass!.getCurrentUser();
    if (status) {
      SharedPref.createInstance().saveFavPokemon(user: user, pokemon: pokemon);
      userFavPokemonList!.add(pokemon);
    } else {
      SharedPref.createInstance()
          .removeFavPokemon(user: user, pokemon: pokemon);
      userFavPokemonList!.remove(pokemon);
    }
    emit(HomeSuccessState(isSuccess: true, pokemonList: pokemonList));
  }
}
