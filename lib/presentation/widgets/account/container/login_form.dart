import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/account_repository.dart';

class LoginForm extends StatelessWidget {
  final VoidCallback onLogin;

  LoginForm({Key key, @required this.onLogin}) : super(key: key);

  final AuthRepository _authenticationRepository =
      new AuthRepository();
  final AccountRepository _accountRepository = new AccountRepository();
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: _usernameCtrl,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter Username...",
              hintStyle: TextStyle(color: Colors.grey),
              icon: Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
            ),
          ),
          TextField(
            controller: _passwordCtrl,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter Password...",
              hintStyle: TextStyle(color: Colors.grey),
              icon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            onPressed: onLogin,
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  void _login() async {
    /*Future<String> future = _authenticationRepository.createSession(
      username: _usernameCtrl.text,
      password: _passwordCtrl.text,
    );
    String session;
    future.then((value) async {
      session = value;
      print("Login Page, My session is: $session");
      if (session != null && session != '') {
        _accountRepository.saveAccountPreference(sessionId: session);
      } else {
        // TODO: Implement login fails here
        print("Login fails");
      }
    });*/
  }
}
