part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthEvent {
  final String sessionId;
  const LogoutEvent(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
