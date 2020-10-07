import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'account_page.dart';
import '../../data/repositories/account_repository.dart';
import '../../data/repositories/authentication_repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthRepository _authenticationRepository =
      new AuthRepository();
  AccountRepository _accountRepository = new AccountRepository();
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
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
                    onPressed: login,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    /*_authenticationRepository
        .createSession(
      username: _usernameCtrl.text,
      password: _passwordCtrl.text,
    )
        .then((session) async {
      if (session != null && session != '') {
        _accountRepository.saveAccountPreference(sessionId: session);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: AccountPage(),
          ),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(
              "Login Fails",
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    }).catchError((error) {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            "Login Fails",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    });*/
  }
}
