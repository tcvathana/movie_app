import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../config.dart';

abstract class IAuthRemoteDataSource {
  Future<String> createRequestToken();

  // RETURN token
  Future<String> validateTokenWithLogin({
    @required String username,
    @required String password,
  });

  // RETURN session_id
  Future<String> createSession({
    @required String requestToken,
  });

  // RETURN BOOLEAN
  Future<bool> deleteSession({@required String sessionId});
}

class AuthRemoteDataSource extends IAuthRemoteDataSource {
  final http.Client client = http.Client();

  @override
  Future<String> createRequestToken() async {
    http.Response response = await http.get(
      "$BASE_URL/authentication/token/new?api_key=$API_KEY",
    );
    final Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final String token = responseMap['request_token'];
      return token;
    } else {
      final String statusMessage = responseMap['status_message'];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<String> validateTokenWithLogin(
      {String username, String password, String requestToken}) async {
    http.Response response = await http.post(
      "$BASE_URL/authentication/token/validate_with_login?api_key=$API_KEY",
      body: {
        "username": username,
        "password": password,
        "request_token": requestToken,
      },
    );
    final Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final String token = responseMap['request_token'];
      return token;
    } else {
      final String statusMessage = responseMap['status_message'];
      throw Exception("ValidateWithLogging ,Error $statusMessage");
    }
  }

  @override
  Future<String> createSession({String requestToken}) async {
    http.Response response = await http.post(
      "$BASE_URL/authentication/session/new?api_key=$API_KEY",
      body: {"request_token": requestToken},
    );
    final Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final String session = responseMap['session_id'];
      print("My session is: $session");
      return session;
    } else {
      final String statusMessage = responseMap['status_message'];
      throw Exception("Create Session, Error $statusMessage");
    }
  }

  @override
  Future<bool> deleteSession({String sessionId}) async {
    http.StreamedResponse response = await client.send(
      http.Request(
        "DELETE",
        Uri.parse(
          "$BASE_URL/authentication/session?api_key=$API_KEY",
        ),
      )..bodyFields = {"session_id": sessionId},
    );
    if (response.statusCode == 200) {
      // response.stream.bytesToString().then((value) => print(value));
      return true;
    } else {
      throw Exception("Delete Session, Error ${response.toString()}");
    }
  }
}
