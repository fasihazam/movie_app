import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MovieRepository {
  final String apiKey = "e0d7d299e7539d78625541fc4ac98faf";

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<String?> fetchTrailerUrl(int movieId) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      if (results.isEmpty) {
        throw Exception("No trailers available for this movie");
      }

      final trailer = results.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (trailer != null) {
        return trailer['key'];
      } else {
        throw Exception("No YouTube trailer found for this movie");
      }
    } else if (response.statusCode == 404) {
      throw Exception("Movie ID not found. Please check the movie ID.");
    } else {
      throw Exception(
          "Failed to load trailer. Status code: ${response.statusCode}");
    }
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception("Failed to load movie details");
    }
  }
}
