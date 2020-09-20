import 'dart:convert';

//AccountStates accountStatesFromJson(String str) => AccountStates.fromMap(json.decode(str));
//
//String accountStatesToJson(AccountStates data) => json.encode(data.toMap());

class MovieAccountStates {
  int id;
  bool favorite;
  bool rated;
  bool watchlist;

  MovieAccountStates({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory MovieAccountStates.fromJson(String str) =>
      MovieAccountStates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieAccountStates.fromMap(Map<String, dynamic> json) =>
      MovieAccountStates(
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
