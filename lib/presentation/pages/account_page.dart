import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import '../widgets/account/favorite_list_button.dart';
import '../widgets/account/watchlist_button.dart';
import '../widgets/account/container/user_profile_container.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthLoaded authLoaded = context.bloc<AuthBloc>().state;
    BlocProvider.of<AccountBloc>(context).add(
      GetAccountEvent(authLoaded.sessionId),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: Colors.red,
            onPressed: dispatchLogout,
          )
        ],
      ),
      body: Container(
        color: Colors.white.withOpacity(0.2),
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoadedState) {
              return AccountPageBody();
            } else if (state is AccountLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AccountErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Center(
                child: Text("Init"),
              );
            }
          },
        ),
      ),
    );
  }

  void dispatchLogout() async {
    final AuthLoaded authLoaded = BlocProvider.of<AuthBloc>(context).state;
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent(authLoaded.sessionId));
  }
}

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserProfileContainer(),
              Divider(
                color: Colors.white,
              ),
              FavoriteListButton(),
              SizedBox(
                height: 10,
              ),
              WatchlistButton(),
            ],
          ),
        ),
      ),
    );
  }
}
