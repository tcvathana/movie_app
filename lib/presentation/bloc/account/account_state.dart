part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoadingState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoadedState extends AccountState {
  final Account account;

  AccountLoadedState(this.account);

  @override
  List<Object> get props => [];
}

class AccountErrorState extends AccountState {
  final String error;

  AccountErrorState(this.error);

  @override
  List<Object> get props => [error];
}
