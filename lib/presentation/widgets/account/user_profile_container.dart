import 'package:flutter/material.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/models/account.dart';

class UserProfileContainer extends StatelessWidget {
  AccountRepository _accountRepository = new AccountRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Account>(
      future: _accountRepository.getAccountPreference(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Account account = snapshot.data;
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
                          account.username == null ? "" : "${account.username}",
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
          } else {
            return Center(
              child: Text("No data available."),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
