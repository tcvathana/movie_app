import 'package:meta/meta.dart';
import '../../data/models/account.dart';

abstract class IAuthenticationRepository {
  // RETURN token
  Future<String> createRequestToken();
  // RETURN token
  Future<String> validateTokenWithLogin({
    @required String username,
    @required String password,
  });
  // RETURN session_id
  Future<String> createSession({
    @required String username,
    @required String password,
  });
  // RETURN BOOLEAN
  Future<bool> deleteSession({@required String sessionId});
}
