import 'dart:convert';

class MovieCredit {
  MovieCredit({
    this.id,
    this.cast,
    this.crew,
  });

  int id;
  List<Cast> cast;
  List<Crew> crew;

  factory MovieCredit.fromJson(String str) => MovieCredit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieCredit.fromMap(Map<String, dynamic> json) => MovieCredit(
    id: json["id"] == null ? null : json["id"],
    cast: json["cast"] == null ? null : List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    crew: json["crew"] == null ? null : List<Crew>.from(json["crew"].map((x) => Crew.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "cast": cast == null ? null : List<dynamic>.from(cast.map((x) => x.toMap())),
    "crew": crew == null ? null : List<dynamic>.from(crew.map((x) => x.toMap())),
  };
}

class Cast {
  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    order: json["order"] == null ? null : json["order"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toMap() => {
    "cast_id": castId == null ? null : castId,
    "character": character == null ? null : character,
    "credit_id": creditId == null ? null : creditId,
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "order": order == null ? null : order,
    "profile_path": profilePath == null ? null : profilePath,
  };
}

class Crew {
  Crew({
    this.creditId,
    this.department,
    this.gender,
    this.id,
    this.job,
    this.name,
    this.profilePath,
  });

  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  factory Crew.fromJson(String str) => Crew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Crew.fromMap(Map<String, dynamic> json) => Crew(
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    department: json["department"] == null ? null : json["department"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    job: json["job"] == null ? null : json["job"],
    name: json["name"] == null ? null : json["name"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toMap() => {
    "credit_id": creditId == null ? null : creditId,
    "department": department == null ? null : department,
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "job": job == null ? null : job,
    "name": name == null ? null : name,
    "profile_path": profilePath == null ? null : profilePath,
  };
}