import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:pokdex/src/resource/NetworkClient.dart';

class HomeProvider {
  Client client = Client();

  Future<NetworkClientState?> fetchData() async {
    NetworkClientState? networkClientState = NetworkClientState.getInstance();
    final response = await networkClientState!.getRequest();
    return response;
  }

  Future<NetworkClientState?> postData(String jsonBody, String endpoint,
      {bool isTest = true}) async {
    return null;
  }
}
