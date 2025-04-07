import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'repositories/music_repository.dart';
import 'screens/home_screen.dart';
import 'screens/artist_details.dart';
import 'screens/album_details.dart';
import 'blocs/artist/artist_bloc.dart';
import 'blocs/artist/artist_event.dart';
import 'blocs/album/album_bloc.dart';
import 'blocs/album/album_event.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeContent(initialTabIndex: 0),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const HomeContent(initialTabIndex: 1),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const HomeContent(initialTabIndex: 2),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/artist/:id',
      builder: (context, state) {
        final artistId = state.pathParameters['id']!;
        return BlocProvider(
          create: (context) => ArtistBloc(
            context.read<MusicRepository>(),
          )..add(LoadArtistDetails(artistId)),
          child: ArtistDetailsScreen(artistId: artistId),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/album/:id',
      builder: (context, state) {
        final albumId = state.pathParameters['id']!;
        return BlocProvider(
          create: (context) => AlbumBloc(
            context.read<MusicRepository>(),
          )..add(LoadAlbumDetails(albumId)),
          child: AlbumDetailsScreen(albumId: albumId),
        );
      },
    ),
  ],
);