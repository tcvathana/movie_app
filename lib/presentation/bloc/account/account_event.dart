part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class GetAccountEvent extends AccountEvent {
  final String sessionId;

  GetAccountEvent(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
