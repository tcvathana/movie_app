import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_account.dart';
import '../../domain/repositories/i_authentication_repository.dart';
import '../../config.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<String> createRequestToken() async {
    http.Response response = await http.get(
      "$SERVICE_URL/authentication/token/new?api_key=$API_KEY",
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      String token = map['request_token'];
      return token;
    } else {
      return null;
      //throw Exception("Request Token, Error ${response.toString()}");
    }
  }

  @override
  Future<String> validateTokenWithLogin({
    String username,
    String password,
  }) async {
    String token;
    await createRequestToken().then((value) => token = value);
    if(token != null) {
      http.Response response = await http.post(
        "$SERVICE_URL/authentication/token/validate_with_login?api_key=$API_KEY",
        body: {
          "username": username,
          "password": password,
          "request_token": token
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        String _token = map['request_token'];
        return _token;
      } else {
        return null;
        //throw Exception("ValidateWithLogging ,Error ${response.toString()}");
      }
    } else {
      return null;
    }
  }

  @override
  Future<String> createSession({String username, String password}) async {
    String token;
    await validateTokenWithLogin(
        username: username,
        password: password,
    ).catchError((error) {
      print("Wrong password or username");
    }).then((value) async {
      token = value;
    });

    if(token != null) {
      print("I'm in create session. Here is my token: $token");
      http.Response response = await http.post(
        "$SERVICE_URL/authentication/session/new?api_key=$API_KEY",
        body: {"request_token": token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        String session = map['session_id'];
        print("My session is: $session");
        return session;
      } else {
        throw Exception("Create Session, Error ${response.toString()}");
      }
    } else {
      return null;
    }
  }
}
