import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';
import 'repositories/music_repository.dart';
import 'repositories/favorites_repository.dart';
import 'models/artist.dart';
import 'models/favorites.dart';

void main() {
  print("1. Démarrage");
  runApp(const SimplifiedApp());
  print("2. App lancée");
}

class SimplifiedApp extends StatelessWidget {
  const SimplifiedApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("3. Construction de SimplifiedApp");
    
    // Initialiser les repositories
    final musicRepository = MusicRepository();
    
    // Utilisez un mock pour les favoris qui ne dépend pas de Hive
    final favoritesRepository = MockFavoritesRepository();
    
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MusicRepository>(
          create: (context) => musicRepository,
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => favoritesRepository,
        ),
      ],
      child: MaterialApp.router(
        title: 'Music App',
        debugShowCheckedModeBanner: true,
        theme: ThemeData.dark(),
        routerConfig: appRouter,
      ),
    );
  }
}

// Une implémentation de FavoritesRepository qui ne dépend pas de Hive
class MockFavoritesRepository implements FavoritesRepository {
  final List<FavoriteArtist> _favorites = [];
  
  @override
  List<FavoriteArtist> getAllFavorites() {
    return _favorites;
  }
  
  @override
  bool isFavorite(String artistId) {
    return _favorites.any((favorite) => favorite.id == artistId);
  }
  
  @override
  Future<void> addFavorite(Artist artist) async {
    if (isFavorite(artist.id)) return;
    
    final favoriteArtist = FavoriteArtist(
      id: artist.id,
      name: artist.name,
      thumbUrl: artist.thumbUrl,
      genre: artist.genre,
    );
    
    _favorites.add(favoriteArtist);
  }
  
  @override
  Future<void> removeFavorite(String artistId) async {
    _favorites.removeWhere((favorite) => favorite.id == artistId);
  }
  
  @override
  Future<bool> toggleFavorite(Artist artist) async {
    if (isFavorite(artist.id)) {
      await removeFavorite(artist.id);
      return false;
    } else {
      await addFavorite(artist);
      return true;
    }
  }
}