import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_state.dart';
import 'package:movie_app/features/presentation/pages/movie_search_delegate.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<MovieListCubit>().fetchMovies();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          'Watch',
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.onPrimary,
        elevation: 4,
        centerTitle: false,
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
            return Center(
              child: TextWidget(
                "Welcome! Fetch movies to get started.",
                style: GoogleFonts.poppins(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/movie-detail",
                        arguments: movie.id,
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: TextWidget(
                              movie.title,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: AppColors.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is MovieListError) {
            return Center(
              child: TextWidget(
                state.errorMessage,
                style: GoogleFonts.poppins(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Unknown state.",
                style: GoogleFonts.poppins(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
