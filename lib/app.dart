import 'package:ece_music/screens/album_details.dart';
import 'package:ece_music/screens/artist_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/album/album_event.dart';
import 'blocs/artist/artist_event.dart';
import 'repositories/music_repository.dart';
import 'repositories/favorites_repository.dart';

import 'screens/home_screen.dart';

import 'blocs/artist/artist_bloc.dart';
import 'blocs/album/album_bloc.dart';
import 'blocs/charts/charts_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'blocs/charts/charts_event.dart';
import 'blocs/favorites/favorites_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MusicRepository repository = MusicRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MusicRepository>.value(value: repository),
        RepositoryProvider<FavoritesRepository>(
          create: (_) => FavoritesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ArtistBloc(repository)),
          BlocProvider(create: (_) => AlbumBloc(repository)),
          BlocProvider(create: (_) => SearchBloc(repository)),
          BlocProvider(create: (_) => ChartsBloc(repository)..add(LoadTopAlbums())),
          BlocProvider(
            create: (context) => FavoritesBloc(context.read<FavoritesRepository>())..add(LoadFavorites()),
          ),
        ],
        child: MaterialApp.router(
  debugShowCheckedModeBanner: false,
  routerConfig: _router(repository),
  theme: ThemeData(
    fontFamily: 'SFPro',
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.green,
      background: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
    ),
  ),
),
      ),
    );
  }
}

GoRouter _router(MusicRepository repository) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/artist/:id',
        builder: (context, state) {
          final artistId = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => ArtistBloc(repository)..add(LoadArtistDetails(artistId)),
            child: ArtistDetailsScreen(artistId: artistId),
          );
        },
      ),
      GoRoute(
        path: '/album/:albumId',
        builder: (context, state) {
          final albumId = state.pathParameters['albumId']!;
          return BlocProvider(
            create: (_) => AlbumBloc(repository)..add(LoadAlbumDetails(albumId)),
            child: AlbumDetailsScreen(albumId: albumId),
          );
        },
      ),
    ],
  );
}
