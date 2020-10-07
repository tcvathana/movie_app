import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/pages/account_page.dart';
import 'package:movie_app/presentation/pages/login_page.dart';

import '../../injection_container.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if(state is AuthInitial) {
          return LoginPage();
        } else if(state is AuthLoaded) {
          return AccountPage();
        } else if(state is AuthError) {
          return LoginPage();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
