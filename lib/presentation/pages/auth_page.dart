import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/pages/account_page.dart';
import 'package:movie_app/presentation/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state){
        if(state is AuthInitial) {
          return LoginPage();
        } else if(state is AuthLoaded) {
          return AccountPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
