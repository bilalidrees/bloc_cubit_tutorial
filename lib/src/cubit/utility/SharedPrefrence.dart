import 'dart:convert';
import 'package:pokdex/src/model/Pokemon.dart';
import 'package:pokdex/src/model/User.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref();

  SharedPref.createInstance();

  Future<bool?> setCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user != null) {
      Map<String, dynamic> result = user.toJson();
      String jsonUser = jsonEncode(result);
      prefs.setString(Strings.CURRENT_USER, jsonUser);
    } else {
      prefs.setString(Strings.CURRENT_USER, null);
    }
    return true;
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String result = prefs.getString(Strings.CURRENT_USER);
    if (result != null) {
      Map<String, dynamic> map = jsonDecode(result);
      return User.fromJson(map);
    } else
      return null;
  }

  Future<bool?> saveFavPokemon({User? user, Pokemon? pokemon}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Pokemon> pokemonList = await getPokemonListFromSharePref(user: user!);
    pokemonList.add(pokemon!);
    List<String> savedList =
        pokemonList.map((item) => json.encode(item.toJson())).toList();
    prefs.setStringList(user.id, savedList);
    return true;
  }

  Future<bool?> removeFavPokemon({User? user, Pokemon? pokemon}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Pokemon> pokemonList = await getPokemonListFromSharePref(user: user!);
    pokemonList.removeWhere((item) => item.name == pokemon!.name);
    List<String> savedList =
        pokemonList.map((item) => json.encode(item.toJson())).toList();
    prefs.setStringList(user.id, savedList);
    return true;
  }

  Future<List<Pokemon>> getFavPokemon({User? user}) async {
    List<Pokemon> pokemonList = await getPokemonListFromSharePref(user: user!);
    return pokemonList;
  }

  Future<List<Pokemon>> getPokemonListFromSharePref({User? user}) async {
    List<Pokemon> pokemonList = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> listString = prefs.getStringList(user!.id);
    if (listString != null) {
      pokemonList = listString
          .map((item) => Pokemon.fromJson(json.decode(item)))
          .toList();
    }
    return pokemonList;
  }
}
