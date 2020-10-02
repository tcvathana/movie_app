import 'dart:convert';

class MovieReview {
  MovieReview({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int id;
  int page;
  List<ResultReview> results;
  int totalPages;
  int totalResults;

  factory MovieReview.fromJson(String str) => MovieReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieReview.fromMap(Map<String, dynamic> json) => MovieReview(
    id: json["id"] == null ? null : json["id"],
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : List<ResultReview>.from(json["results"].map((x) => ResultReview.fromMap(x))),
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    totalResults: json["total_results"] == null ? null : json["total_results"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "page": page == null ? null : page,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toMap())),
    "total_pages": totalPages == null ? null : totalPages,
    "total_results": totalResults == null ? null : totalResults,
  };
}

class ResultReview {
  ResultReview({
    this.id,
    this.author,
    this.content,
    this.url,
  });

  String id;
  String author;
  String content;
  String url;

  factory ResultReview.fromJson(String str) => ResultReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultReview.fromMap(Map<String, dynamic> json) => ResultReview(
    id: json["id"] == null ? null : json["id"],
    author: json["author"] == null ? null : json["author"],
    content: json["content"] == null ? null : json["content"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "author": author == null ? null : author,
    "content": content == null ? null : content,
    "url": url == null ? null : url,
  };
}