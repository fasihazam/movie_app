import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/data/models/movie_model.dart';
import 'package:movie_app/features/data/repo/movie_repository.dart';
import 'package:movie_app/features/presentation/pages/seat_mapping_screen.dart';
import 'package:movie_app/features/presentation/pages/trailer_player_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Movie>(
        future: MovieRepository().fetchMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return const Center(
                child: TextWidget('No movie details available.'));
          }

          final movie = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MoviePosterSection(movie: movie),
                _GenresAndOverviewSection(movie: movie),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MoviePosterSection extends StatelessWidget {
  final Movie movie;

  const _MoviePosterSection({required this.movie});

  String _formatReleaseDate(String releaseDate) {
    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('MMMM dd, yyyy');
      final date = inputFormat.parse(releaseDate);
      return 'In theaters ${outputFormat.format(date)}';
    } catch (e) {
      return 'Release Date: $releaseDate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500${movie.posterPath}"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  _formatReleaseDate(movie.releaseDate),
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: 240.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatMappingScreen(
                            movieName: movie.title,
                            releaseDate: movie.releaseDate,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor: AppColors.inputBorder,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Get Tickets",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 240.w,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TrailerPlayerScreen(movieId: movie.id),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow, size: 30),
                    label: Text("Watch Trailer",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor: Colors.transparent,
                      iconColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: AppColors.inputBorder,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenresAndOverviewSection extends StatelessWidget {
  final Movie movie;

  const _GenresAndOverviewSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Genres Label
            TextWidget(
              "Genres",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _GenreButton(label: "Action", color: AppColors.green),
                _GenreButton(label: "Thriller", color: AppColors.pink),
                _GenreButton(label: "Science", color: AppColors.purple),
                _GenreButton(label: "Fiction", color: AppColors.yellow),
              ],
            ),
            SizedBox(height: 20.h),

            Text(
              "Overview",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              movie.overview,
              style: GoogleFonts.poppins(
                  fontSize: 16, height: 1.5, color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenreButton extends StatelessWidget {
  final String label;
  final Color color;

  const _GenreButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
