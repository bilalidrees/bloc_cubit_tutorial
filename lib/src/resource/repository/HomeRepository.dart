import 'package:pokdex/src/model/Pokemon.dart';
import 'package:pokdex/src/resource/NetworkClient.dart';
import 'package:pokdex/src/resource/provider/HomeProvider.dart';
import 'dart:convert';

class HomeRepository {
  final homeProvider = HomeProvider();

  HomeRepository();

  Future<List<Pokemon>?> fetchPokemons() async {
    NetworkClientState? response = await homeProvider.fetchData();
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsedData = json.decode(onSuccessState.response);
      List<dynamic> responseData = parsedData["results"] as List<dynamic>;
      return (responseData).map((i) => Pokemon.fromJson(i)).toList();
    } else if (response is OnErrorState) {
      OnErrorState onErrorState = response;
      throw onErrorState.error;
    } else if (response is OnFailureState) {
      OnFailureState onErrorState = response;
      throw onErrorState.throwable;
    }
    return null;
  }
}
