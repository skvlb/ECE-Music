import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepository {
  final _favoritesBox = Hive.box<String>('favorites');

  List<String> getFavoriteIds() {
    return _favoritesBox.values.toList();
  }

  void addFavorite(String id) {
    _favoritesBox.put(id, id);
  }

  void removeFavorite(String id) {
    _favoritesBox.delete(id);
  }

  bool isFavorite(String id) {
    return _favoritesBox.containsKey(id);
  }
  void toggleFavorite(String id) {
    if (isFavorite(id)) {
      removeFavorite(id);
    } else {
      addFavorite(id);
    }
  }
}
