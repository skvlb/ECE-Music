import 'package:equatable/equatable.dart';
import '../../models/artist.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  
  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final Artist artist;
  
  const ToggleFavorite(this.artist);
  
  @override
  List<Object> get props => [artist];
}