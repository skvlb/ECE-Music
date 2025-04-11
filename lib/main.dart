import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'repositories/music_repository.dart';
import 'repositories/favorites_repository.dart';

import 'screens/home_screen.dart';
import 'screens/artist_details.dart';
import 'screens/album_details.dart';

import 'blocs/artist/artist_bloc.dart';
import 'blocs/album/album_bloc.dart';
import 'blocs/charts/charts_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';

import 'blocs/charts/charts_event.dart';
import 'blocs/favorites/favorites_event.dart';
import 'blocs/artist/artist_event.dart';
import 'blocs/album/album_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('favorites');

  runApp(MyApp());
}


