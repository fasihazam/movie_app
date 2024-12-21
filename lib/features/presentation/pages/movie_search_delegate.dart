import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/shared_widgets/base_scaffold_widget.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_state.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'TV shows, movies and more';

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
    if (query.isNotEmpty) {
      context.read<MovieListCubit>().searchMovies(query);
    }

    return BaseScaffoldWidget(body: BlocBuilder<MovieListCubit, MovieListState>(
      builder: (context, state) {
        if (state is MovieListLoaded) {
          final filteredMovies = state.movies;

          if (query.isEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 16 / 9,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/movie-detail',
                      arguments: movie.id,
                    );
                  },
                  child: Stack(
                    children: [
                      // Movie Poster with 16:9 Aspect Ratio
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Movie Title at the bottom left of the image
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          movie.title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            // If query is not empty, show search results in a simple list format
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/movie-detail',
                      arguments: movie.id,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                            width: 130.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  movie.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movie.releaseDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          color: AppColors.inputBorder,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
