import 'package:meta/meta.dart';

abstract class IAuthRepository {
  // RETURN token
  Future<String> createRequestToken();

  // RETURN token
  Future<String> validateTokenWithLogin({
    @required String username,
    @required String password,
    @required String requestToken,
  });

  // RETURN session_id
  Future<String> createSession({
    @required String requestToken,
  });

  // RETURN BOOLEAN
  Future<bool> deleteSession({@required String sessionId});
}
