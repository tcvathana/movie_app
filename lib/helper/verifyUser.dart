import 'package:http/http.dart' as http;
import '../data/models/user_account.dart';
import '../config.dart';

Future<UserAccount> fetchAccountDetails(String sessionId) async {
  http.Response response = await http.get(
    "$SERVICE_URL/account?api_key=$API_KEY&session_id=$sessionId",
  );
  if (response.statusCode == 200) {
    return UserAccount.fromJson(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

/*
String _token;
// Step
Future<String> createRequestToken() async {
  http.Response response = await http.get(
    "$SERVICE_URL/authentication/token/new?api_key=$API_KEY",
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    String token = map['request_token'];
    _token = token;
    return token;
  } else {
    throw Exception("Request Token, Error ${response.toString()}");
  }
}

Future<String> validateTokenWithLogin(String username, String password) async {
  await createRequestToken();
  http.Response response = await http.post(
    "$SERVICE_URL/authentication/token/validate_with_login?api_key=$API_KEY",
    body: {"username": username, "password": password, "request_token": _token},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    String token = map['request_token'];
    _token = token;
    return token;
  } else {
    throw Exception("ValidateWithLogging ,Error ${response.toString()}");
  }
}

Future<String> createSession(String username, String password) async {
  String token;
  await validateTokenWithLogin(
    username,
    password,
  ).catchError((error) {
    print("Wrong password or username");
  }).then((value) async {
    token = value;
  });

  if(token != null) {
    print("I'm in create session. Here is my token: $_token");
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
*/
