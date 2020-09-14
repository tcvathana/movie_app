import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'account_page.dart';
import '../../models/user_account.dart';
import '../../helper/verifyUser.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _usernameCtrl = TextEditingController();
  var _passwordCtrl = TextEditingController();

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
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black87,
    );
  }

  _buildBody(context) {
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
                    onPressed: () async {
                      Future<String> future = fetchCreateSession(
                          _usernameCtrl.text, _passwordCtrl.text);
                      String session = '';
                      future.then((value) async {
                        session = value;
                        print("Login Page, My session is: ${session}");

                        if (session != null && session != '') {
                          Future<UserAccount> futureUser = fetchAccountData(session);
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: AccountPage()));
                        } else {
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text(
                                "Login Fails",
                                style: TextStyle(color: Colors.red),
                              )));
                        }
                      });

                    },
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
}
