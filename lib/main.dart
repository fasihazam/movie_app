import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/cubits/bottom_nav/bottom_nav_cubit.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/data/repo/movie_repository.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/pages/home_page.dart';
import 'package:movie_app/features/presentation/pages/movie_detail_screen.dart';
import 'package:movie_app/features/presentation/pages/trailer_player_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final movieRepository = MovieRepository();

  runApp(MyApp(movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizerUtils(
      builder: (context, orientation) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<MovieListCubit>(
              create: (_) => MovieListCubit(repository),
            ),
            BlocProvider(
              create: (_) => BottomNavCubit(),
            ),
          ],
          child: MaterialApp(
            title: 'Movie App',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/movie-detail': (context) => MovieDetailScreen(
                    movieId: ModalRoute.of(context)!.settings.arguments as int,
                  ),
              '/trailer-player': (context) => TrailerPlayerScreen(
                    movieId: ModalRoute.of(context)!.settings.arguments as int,
                  ),
            },
          ),
        );
      },
    );
  }
}
