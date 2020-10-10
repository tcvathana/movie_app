import 'package:flutter/material.dart';
import 'package:movie_app/data/data_sources/remote/auth_remote_data_source.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({this.remoteDataSource});

  @override
  Future<String> createRequestToken() async {
    return remoteDataSource.createRequestToken();
  }

  @override
  Future<String> validateTokenWithLogin({
    String username,
    String password,
    String requestToken,
  }) async {
    return remoteDataSource.validateTokenWithLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );
  }

  @override
  Future<String> createSession({
    String requestToken,
  }) async {
    return remoteDataSource.createSession(
      requestToken: requestToken,
    );
  }

  @override
  Future<bool> deleteSession({@required String sessionId}) async {
    return remoteDataSource.deleteSession(sessionId: sessionId);
  }
}
