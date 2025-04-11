abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final String artistId;

  ToggleFavorite(this.artistId);
}
