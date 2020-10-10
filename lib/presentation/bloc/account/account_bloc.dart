import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/account.dart';
import 'package:movie_app/data/repositories/account_repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({this.accountRepository}) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is GetAccountEvent) {
      try {
        yield AccountLoadingState();
        final account = await accountRepository.getAccountDetails(
          sessionId: event.sessionId,
        );
        yield AccountLoadedState(account);
      } catch(e) {
        yield AccountErrorState(e.message);
      }
    }
  }
}
