import 'dart:convert';

class MovieVideo {
  MovieVideo({
    this.id,
    this.results,
  });

  int id;
  List<ResultVideo> results;

  factory MovieVideo.fromJson(String str) => MovieVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieVideo.fromMap(Map<String, dynamic> json) => MovieVideo(
    id: json["id"] == null ? null : json["id"],
    results: json["results"] == null ? null : List<ResultVideo>.from(json["results"].map((x) => ResultVideo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class ResultVideo {
  ResultVideo({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  factory ResultVideo.fromJson(String str) => ResultVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultVideo.fromMap(Map<String, dynamic> json) => ResultVideo(
    id: json["id"] == null ? null : json["id"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null : json["name"],
    site: json["site"] == null ? null : json["site"],
    size: json["size"] == null ? null : json["size"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "iso_3166_1": iso31661 == null ? null : iso31661,
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "site": site == null ? null : site,
    "size": size == null ? null : size,
    "type": type == null ? null : type,
  };
}
