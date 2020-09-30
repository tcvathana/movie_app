class MovieReview {
  int id;
  int page;
  List<ResultReview> results;
  int totalPages;
  int totalResults;

  MovieReview({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieReview.fromJson(Map<String, dynamic> json) => MovieReview(
    id: json["id"],
    page: json["page"],
    results: List<ResultReview>.from(json["results"].map((x) => ResultReview.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class ResultReview {
  String author;
  String content;
  String id;
  String url;

  ResultReview({
    this.author,
    this.content,
    this.id,
    this.url,
  });

  factory ResultReview.fromJson(Map<String, dynamic> json) => ResultReview(
    author: json["author"],
    content: json["content"],
    id: json["id"],
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "content": content,
    "id": id,
    "url": url,
  };
}