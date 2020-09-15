import 'dart:convert';

//AccountStates accountStatesFromJson(String str) => AccountStates.fromMap(json.decode(str));
//
//String accountStatesToJson(AccountStates data) => json.encode(data.toMap());

class AccountStates {
  int id;
  bool favorite;
  bool rated;
  bool watchlist;

  AccountStates({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory AccountStates.fromMap(Map<String, dynamic> json) => AccountStates(
    id: json["id"] == null ? null : json["id"],
    favorite: json["favorite"] == null ? null : json["favorite"],
    rated: json["rated"] == null ? null : json["rated"],
    watchlist: json["watchlist"] == null ? null : json["watchlist"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "favorite": favorite == null ? null : favorite,
    "rated": rated == null ? null : rated,
    "watchlist": watchlist == null ? null : watchlist,
  };
}
