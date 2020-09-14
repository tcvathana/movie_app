import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../models/user_account.dart';
import '../config.dart';

UserAccount _parseAccountData(String input) {
  Map<String, dynamic> map = json.decode(input);
  UserAccount user = UserAccount.fromMap(map);
  return user;
}

Future<UserAccount> fetchAccountData(sessionId) async {
  http.Response response = await http.get(
      "https://api.themoviedb.org/3/account?api_key=$API_KEY&session_id=$sessionId",
  );
  if (response.statusCode == 200) {
    return compute(_parseAccountData, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

String _token;
// Step
Future<String> fetchTokenData() async {
  http.Response response = await http.get(
    "https://api.themoviedb.org/3/authentication/token/new?api_key=$API_KEY",
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    String token = map['request_token'];
    print("My token is ${token}");
    _token=token;
    return token;
  } else {
    throw Exception("Request Token, Error ${response.toString()}");
  }
}
Future<String> validateTokenWithLogin(String username, String password) async {
  var test = await fetchTokenData();
//  print(_token);
  http.Response response = await http.post(
    "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$API_KEY",
    body: {
      "username": username,
      "password": password,
      "request_token": _token
    }
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    String token = map['request_token'];
    _token=token;
    return token;
  } else {
    throw Exception("ValidateWithLoging ,Error ${response.toString()}");
  }
}
Future<String> fetchCreateSession(String username, String password) async {
  var test = await validateTokenWithLogin(username, password);
  print("I'm in create session. Here is my token: ${_token}");
  http.Response response = await http.post(
    "https://api.themoviedb.org/3/authentication/session/new?api_key=$API_KEY",
    body: {
      "request_token": _token
    }
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    String session = map['session_id'];
    print("My session is: $session");
    return session;
  } else {
    throw Exception("Create Session, Error ${response.toString()}");
  }
}





