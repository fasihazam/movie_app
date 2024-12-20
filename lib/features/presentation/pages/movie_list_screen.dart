import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_state.dart';
import 'package:movie_app/features/presentation/pages/movie_search_delegate.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<MovieListCubit>().fetchMovies();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upcoming Movies',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieListCubit, MovieListState>(
        builder: (context, state) {
          if (state is MovieListInitial) {
            return const Center(
              child: Text(
                "Welcome! Fetch movies to get started.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else if (state is MovieListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieListLoaded) {
            final movies = context.read<MovieListCubit>().currentMovies;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        movie.releaseDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/movie-detail",
                            arguments: movie.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is MovieListError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Unknown state.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
