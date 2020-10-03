import 'dart:convert';

class MovieList {
  MovieList({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  List<ResultMovie> results;
  int page;
  int totalResults;
  Dates dates;
  int totalPages;

  factory MovieList.fromJson(String str) => MovieList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieList.fromMap(Map<String, dynamic> json) => MovieList(
    results: json["results"] == null ? null : List<ResultMovie>.from(json["results"].map((x) => ResultMovie.fromMap(x))),
    page: json["page"] == null ? null : json["page"],
    totalResults: json["total_results"] == null ? null : json["total_results"],
    dates: json["dates"] == null ? null : Dates.fromMap(json["dates"]),
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
  );

  Map<String, dynamic> toMap() => {
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toMap())),
    "page": page == null ? null : page,
    "total_results": totalResults == null ? null : totalResults,
    "dates": dates == null ? null : dates.toMap(),
    "total_pages": totalPages == null ? null : totalPages,
  };
}

class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
    maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
    minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toMap() => {
    "maximum": maximum == null ? null : "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum": minimum == null ? null : "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}

class ResultMovie {
  ResultMovie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;

  factory ResultMovie.fromJson(String str) => ResultMovie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultMovie.fromMap(Map<String, dynamic> json) => ResultMovie(
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    video: json["video"] == null ? null : json["video"],
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    id: json["id"] == null ? null : json["id"],
    adult: json["adult"] == null ? null : json["adult"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    title: json["title"] == null ? null : json["title"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    overview: json["overview"] == null ? null : json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
  );

  Map<String, dynamic> toMap() => {
    "popularity": popularity == null ? null : popularity,
    "vote_count": voteCount == null ? null : voteCount,
    "video": video == null ? null : video,
    "poster_path": posterPath == null ? null : posterPath,
    "id": id == null ? null : id,
    "adult": adult == null ? null : adult,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "title": title == null ? null : title,
    "vote_average": voteAverage == null ? null : voteAverage,
    "overview": overview == null ? null : overview,
    "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
  };
}