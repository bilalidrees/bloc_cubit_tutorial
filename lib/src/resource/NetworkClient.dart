import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pokdex/src/cubit/utility/SessionClass.dart';
import 'NetworkConstant.dart';

class NetworkClientState {
  BuildContext? _buildContext;
  static NetworkClientState? networkClientState;
  SessionClass? sessionClass;
  String? token, apiUrl;
  var apiResponse;

  NetworkClientState.createInstance() {
    print("create instance");
  }

  NetworkClientState();

  static NetworkClientState? getInstance() {
    if (networkClientState == null) {
      networkClientState = NetworkClientState();
    }
    return networkClientState;
  }

  Future<void> setSessionToken() async {
    sessionClass = await SessionClass.getInstance();
  }

  Future<NetworkClientState?> postRequest() async {
    try {
      apiResponse = await http.post("endpoint", body: json, headers: {
        "Content-type": "application/json",
      });

      print("response ${apiResponse.body}");
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
        return NetworkClientState._onSuccess(
          apiResponse.body,
        );
      } else {
        if (apiResponse.statusCode == 500)
          return NetworkClientState._onError(
            NetworkConstants.SERVER_ERROR,
          );
        else if (apiResponse.statusCode == 401 ||
            apiResponse.statusCode == 403) {
        } else
          return NetworkClientState._onError(
            "${apiResponse.body} ${apiResponse.statusCode}",
          );
      }
    } on TimeoutException catch (_) {
      return NetworkClientState._onFailure(
        Exception("Timeout occured"),
      );
    } on Error catch (_) {
      if (apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(
          Exception("on error triggered"),
        );
      }
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(
        exception,
      );
    }
  }

  Future<NetworkClientState?> putRequest() async {
    try {
      apiResponse = await http.put("URL", body: json, headers: {
        "Content-type": "application/json",
      });
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200)
        return NetworkClientState._onSuccess(
          apiResponse.body,
        );
      else {
        if (apiResponse.statusCode == 500)
          return NetworkClientState._onError(
            NetworkConstants.SERVER_ERROR,
          );
        else if (apiResponse.statusCode == 401 ||
            apiResponse.statusCode == 403) {
        } else
          return NetworkClientState._onError(
            "${apiResponse.body} ${apiResponse.statusCode}",
          );
      }
    } on TimeoutException catch (_) {
      return NetworkClientState._onFailure(
        Exception("Timeout occured"),
      );
    } on Error catch (_) {
      if (apiResponse.statusCode == 401 || apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(
          Exception("on error triggered"),
        );
      }
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(
        exception,
      );
    }
  }

  Future<NetworkClientState?> getRequest() async {
    try {
      apiResponse = await http.get(NetworkConstants.PRODUCTION_URL);
      if (apiResponse.statusCode == 200)
        return NetworkClientState._onSuccess(
          apiResponse.body,
        );
      else {
        if (apiResponse.statusCode == 500)
          return NetworkClientState._onError(
            NetworkConstants.SERVER_ERROR,
          );
        else if (apiResponse.statusCode == 401 ||
            apiResponse.statusCode == 403) {
        } else
          return NetworkClientState._onError(
            "${apiResponse.body} ${apiResponse.statusCode}",
          );
      }
    } on Error catch (_) {
      if (apiResponse.statusCode == 401 || apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(
          Exception("on error triggered"),
        );
      }
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(
        exception,
      );
    }
  }

  Future<NetworkClientState?> deleteRequest(
      {String? endpoint, String? json, bool isTest = true}) async {
    try {
      apiResponse = await http.post("$endpoint", body: json, headers: {
        "Content-type": "application/json",
      });
      if (apiResponse.statusCode == 200)
        return NetworkClientState._onSuccess(
          apiResponse.body,
        );
      else {
        if (apiResponse.statusCode == 500)
          return NetworkClientState._onError(
            NetworkConstants.SERVER_ERROR,
          );
        else if (apiResponse.statusCode == 401 ||
            apiResponse.statusCode == 403) {
        } else
          return NetworkClientState._onError(
            "${apiResponse.body} ${apiResponse.statusCode}",
          );
      }
    } on Exception catch (exception) {
      return NetworkClientState._onFailure(
        exception,
      );
    }
  }

  factory NetworkClientState._onSuccess(String response) = OnSuccessState;

  factory NetworkClientState._onError(String error) = OnErrorState;

  factory NetworkClientState._onFailure(Exception throwable) = OnFailureState;
}

class OnSuccessState extends NetworkClientState {
  String response;

  OnSuccessState(this.response) : super.createInstance();
}

class OnErrorState extends NetworkClientState {
  String error;

  OnErrorState(this.error) : super.createInstance();
}

class OnFailureState extends NetworkClientState {
  Exception throwable;

  OnFailureState(this.throwable) : super.createInstance();
}
