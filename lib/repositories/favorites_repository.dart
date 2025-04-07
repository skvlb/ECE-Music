import 'package:hive/hive.dart';
import '../models/favorites.dart';
import '../models/artist.dart';

class FavoritesRepository {
  final Box<FavoriteArtist> _favoritesBox = Hive.box<FavoriteArtist>('favorites');
  
  // Obtenir tous les favoris
  List<FavoriteArtist> getAllFavorites() {
    return _favoritesBox.values.toList();
  }
  
  // Vérifier si un artiste est un favori
  bool isFavorite(String artistId) {
    return _favoritesBox.values.any((favorite) => favorite.id == artistId);
  }
  
  // Ajouter un artiste aux favoris
  Future<void> addFavorite(Artist artist) async {
    if (isFavorite(artist.id)) return;
    
    final favoriteArtist = FavoriteArtist(
      id: artist.id,
      name: artist.name,
      thumbUrl: artist.thumbUrl,
      genre: artist.genre,
    );
    
    await _favoritesBox.add(favoriteArtist);
  }
  
  // Supprimer un artiste des favoris
  Future<void> removeFavorite(String artistId) async {
    final keys = _favoritesBox.keys.where(
      (key) => _favoritesBox.get(key)?.id == artistId
    ).toList();
    
    for (final key in keys) {
      await _favoritesBox.delete(key);
    }
  }
  
  // Basculer l'état favori d'un artiste
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