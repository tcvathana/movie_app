import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/account.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';


class UserProfileContainer extends StatelessWidget {

  UserProfileContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountLoadedState accountState = context.bloc<AccountBloc>().state;
    final Account account = accountState.account;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  account.username == null
                      ? ""
                      : "${account.username}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
