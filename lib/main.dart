import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/data/repo/movie_repository.dart';
import 'package:movie_app/features/presentation/cubit/movie_list_cubit.dart';
import 'package:movie_app/features/presentation/pages/movie_detail_screen.dart';
import 'package:movie_app/features/presentation/pages/movie_list_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListCubit>(
          create: (_) => MovieListCubit(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const MovieListScreen(),
          '/movie-detail': (context) => MovieDetailScreen(
                movieId: ModalRoute.of(context)!.settings.arguments as int,
              ),
          '/trailer-player': (context) => TrailerPlayerScreen(
                movieId: ModalRoute.of(context)!.settings.arguments as int,
              ),
        },
      ),
    );
  }
}
