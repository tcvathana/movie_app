import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/repositories/authentication_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({this.authRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      try{
        yield AuthLoading();
        String requestToken = await authRepository.createRequestToken();
        String requestTokenNew = await authRepository.validateTokenWithLogin(
          username: event.username,
          password: event.password,
          requestToken: requestToken,
        );
        String sessionId = await authRepository.createSession(
          requestToken: requestTokenNew,
        );
        yield AuthLoaded(sessionId);
      } catch (e) {
        yield AuthError(e.message);
      }
    } else {
      yield AuthInitial();
    }
  }
}
