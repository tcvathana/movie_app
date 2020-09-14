class MovieDetail {
  bool adult;
  String backdropPath;
//  BelongsToCollection belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetail({
    this.adult,
    this.backdropPath,
//    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetail.fromMap(Map<String, dynamic> map) => MovieDetail(
    adult: map["adult"],
    backdropPath: map["backdrop_path"],
//    belongsToCollection: BelongsToCollection.fromMap(map["belongs_to_collection"]) ?? new BelongsToCollection(),
    budget: map["budget"],
    genres: List<Genre>.from(map["genres"].map((x) => Genre.fromMap(x))),
    homepage: map["homepage"],
    id: map["id"],
    imdbId: map["imdb_id"],
    originalLanguage: map["original_language"],
    originalTitle: map["original_title"],
    overview: map["overview"],
    popularity: map["popularity"].toDouble(),
    posterPath: map["poster_path"],
    productionCompanies: List<ProductionCompany>.from(map["production_companies"].map((x) => ProductionCompany.fromMap(x))),
    productionCountries: List<ProductionCountry>.from(map["production_countries"].map((x) => ProductionCountry.fromMap(x))),
    releaseDate: DateTime.parse(map["release_date"]),
    revenue: map["revenue"],
    runtime: map["runtime"],
    spokenLanguages: List<SpokenLanguage>.from(map["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
    status: map["status"],
    tagline: map["tagline"],
    title: map["title"],
    video: map["video"],
    voteAverage: map["vote_average"].toDouble(),
    voteCount: map["vote_count"],
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "backdrop_path": backdropPath,
//    "belongs_to_collection": belongsToCollection.toMap(),
    "budget": budget,
    "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toMap())),
    "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toMap())),
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toMap())),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({
    this.id=0,
    this.name="",
    this.posterPath="",
    this.backdropPath="",
  });

  factory BelongsToCollection.fromMap(Map<String, dynamic> map) => BelongsToCollection(
    id: map["id"] ??= 0,
    name: map["name"] ??= '',
    posterPath: map["poster_path"] ??= '',
    backdropPath: map["backdrop_path"] ??= '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "backdrop_path": backdropPath,
  };
}

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromMap(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"],
    logoPath: json["logo_path"] ?? '',
    name: json["name"],
    originCountry: json["origin_country"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromMap(Map<String, dynamic> json) => ProductionCountry(
    iso31661: json["iso_3166_1"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "iso_3166_1": iso31661,
    "name": name,
  };
}

class SpokenLanguage {
  String iso6391;
  String name;

  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "iso_639_1": iso6391,
    "name": name,
  };
}
