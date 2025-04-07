import 'package:equatable/equatable.dart';
import '../../models/favorites.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<FavoriteArtist> favorites;
  final String? errorMessage;
  
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.errorMessage,
  });
  
  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoriteArtist>? favorites,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, favorites, errorMessage];
}
