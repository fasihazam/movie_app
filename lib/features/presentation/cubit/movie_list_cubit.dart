import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/data/models/movie_model.dart';
import 'package:movie_app/features/data/repo/movie_repository.dart';

import 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final MovieRepository repository;
  List<Movie> _allMovies = [];
  List<Movie>? _filteredMovies;

  MovieListCubit(this.repository) : super(MovieListInitial());

  Future<void> fetchMovies() async {
    emit(MovieListLoading());
    try {
      final movies = await repository.fetchUpcomingMovies();
      _allMovies = movies;
      _filteredMovies = null;
      emit(MovieListLoaded(_allMovies));
    } catch (e) {
      emit(MovieListError("Failed to load movies. Please try again."));
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _filteredMovies = null;
      emit(MovieListLoaded(_allMovies));
    } else {
      final filteredMovies = _allMovies.where((movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _filteredMovies = filteredMovies;
      emit(MovieListLoaded(filteredMovies));
    }
  }

  List<Movie> get currentMovies => _filteredMovies ?? _allMovies;
}
