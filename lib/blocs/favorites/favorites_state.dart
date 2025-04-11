enum FavoritesStatus { initial, loading, success }

class FavoritesState {
  final FavoritesStatus status;
  final List<String> favoriteIds;

  FavoritesState({required this.status, required this.favoriteIds});

  factory FavoritesState.initial() =>
      FavoritesState(status: FavoritesStatus.initial, favoriteIds: []);

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<String>? favoriteIds,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
