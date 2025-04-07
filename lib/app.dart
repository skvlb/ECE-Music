// app.dart - Configuration de l'application
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';
import 'repositories/music_repository.dart';
import 'repositories/favorites_repository.dart';
import 'blocs/charts/charts_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'blocs/charts/charts_event.dart';
import 'blocs/favorites/favorites_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser les repositories
    final musicRepository = MusicRepository();
    final favoritesRepository = FavoritesRepository();
    
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MusicRepository>(
          create: (context) => musicRepository,
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => favoritesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ChartsBloc>(
            create: (context) => ChartsBloc(musicRepository)..add(LoadCharts()),
          ),
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(musicRepository),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(favoritesRepository)..add(LoadFavorites()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Music App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
textTheme: ThemeData.dark().textTheme.copyWith(

),
          ),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}