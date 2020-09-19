import 'dart:convert';

class UserAccount {
  Avatar avatar;
  int id;
  String iso6391;
  String iso31661;
  String name;
  bool includeAdult;
  String username;

  UserAccount({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  factory UserAccount.fromJson(String str) => UserAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserAccount.fromMap(Map<String, dynamic> json) => UserAccount(
    avatar: json["avatar"] == null ? null : Avatar.fromMap(json["avatar"]),
    id: json["id"] == null ? null : json["id"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
    name: json["name"] == null ? null : json["name"],
    includeAdult: json["include_adult"] == null ? null : json["include_adult"],
    username: json["username"] == null ? null : json["username"],
  );

  Map<String, dynamic> toMap() => {
    "avatar": avatar == null ? null : avatar.toMap(),
    "id": id == null ? null : id,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "iso_3166_1": iso31661 == null ? null : iso31661,
    "name": name == null ? null : name,
    "include_adult": includeAdult == null ? null : includeAdult,
    "username": username == null ? null : username,
  };
}

class Avatar {
  Gravatar gravatar;

  Avatar({
    this.gravatar,
  });

  factory Avatar.fromMap(Map<String, dynamic> json) => Avatar(
    gravatar: json["gravatar"] == null ? null : Gravatar.fromMap(json["gravatar"]),
  );

  Map<String, dynamic> toMap() => {
    "gravatar": gravatar == null ? null : gravatar.toMap(),
  };
}

class Gravatar {
  String hash;

  Gravatar({
    this.hash,
  });

  factory Gravatar.fromMap(Map<String, dynamic> json) => Gravatar(
    hash: json["hash"] == null ? null : json["hash"],
  );

  Map<String, dynamic> toMap() => {
    "hash": hash == null ? null : hash,
  };
}