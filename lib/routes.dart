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

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/artist/:id',
      builder: (context, state) {
        final artistId = state.pathParameters['id']!;
        return BlocProvider(
          create: (_) => ArtistBloc(
            RepositoryProvider.of<MusicRepository>(context),
          )..add(LoadArtistDetails(artistId)),
          child: ArtistDetailsScreen(artistId: artistId),
        );
      },
    ),
    GoRoute(
      path: '/album/:albumId',
      builder: (context, state) {
        final albumId = state.pathParameters['albumId']!;
        print(">>> DEBUG: Navigating to albumId = $albumId");

        return BlocProvider(
          create: (_) => AlbumBloc(
            RepositoryProvider.of<MusicRepository>(context),
          )..add(LoadAlbumDetails(albumId)),
          child: AlbumDetailsScreen(albumId: albumId),
        );
      },
    ),
  ],
);
