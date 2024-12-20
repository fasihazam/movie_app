import 'package:movie_app/features/data/models/movie_model.dart';

abstract class MovieListState {}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;

  MovieListLoaded(this.movies);
}

class MovieListError extends MovieListState {
  final String errorMessage;

  MovieListError(this.errorMessage);
}

abstract class TrailerState {}

class TrailerInitial extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailerLoaded extends TrailerState {
  final String trailerKey;

  TrailerLoaded(this.trailerKey);
}

class TrailerError extends TrailerState {
  final String message;

  TrailerError(this.message);
}
