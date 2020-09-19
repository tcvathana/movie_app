import '../../data/models/account.dart';

abstract class IAccountRepository {
  Future<Account> fetchAccountDetails({String sessionId});
  Future<Account> saveAccountPreference({String sessionId});
  Future<Account> getAccountPreference();
}