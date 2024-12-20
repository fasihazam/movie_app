import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_state.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          context.read<MovieListCubit>().searchMovies(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<MovieListCubit>().searchMovies(query);

    return BlocBuilder<MovieListCubit, MovieListState>(
      builder: (context, state) {
        if (state is MovieListLoaded) {
          final filteredMovies = state.movies;

          return ListView.builder(
            itemCount: filteredMovies.length,
            itemBuilder: (context, index) {
              final movie = filteredMovies[index];
              return ListTile(
                leading: Image.network(
                  "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                  width: 50,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/movie-detail',
                    arguments: movie.id,
                  );
                },
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
