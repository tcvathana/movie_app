import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';

class LoginForm extends StatefulWidget {

  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

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
            onPressed: dispatchLogin,
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

  void dispatchLogin() async {
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
      _usernameCtrl.text,
      _passwordCtrl.text,
    ));
  }
}
