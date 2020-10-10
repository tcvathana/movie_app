part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final String sessionId;

  AuthLoaded(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
class AuthError extends AuthState{
  final String error;

  AuthError(this.error);

  @override
  List<Object> get props => [error];
}
