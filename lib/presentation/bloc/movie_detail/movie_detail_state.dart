part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final MovieReview movieReview;
  final MovieVideo movieVideo;
  final MovieCredit movieCredit;
  final MovieList movieSimilar;

  MovieDetailLoaded({
    this.movieDetail,
    this.movieReview,
    this.movieVideo,
    this.movieCredit,
    this.movieSimilar,
  });

  @override
  List<Object> get props => [
        movieDetail,
        movieReview,
        movieVideo,
        movieCredit,
        movieSimilar,
      ];
}

class MovieDetailError extends MovieDetailState {
  final String error;

  MovieDetailError(this.error);

  @override
  List<Object> get props => [error];
}
