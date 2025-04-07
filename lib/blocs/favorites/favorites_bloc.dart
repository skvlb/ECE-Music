import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  
  FavoritesBloc(this._favoritesRepository) : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }
  
  void _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(status: FavoritesStatus.loading));
    
    try {
      final favorites = _favoritesRepository.getAllFavorites();
      emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
  
  Future<void> _onToggleFavorite(
    ToggleFavorite event, 
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesRepository.toggleFavorite(event.artist);
      add(LoadFavorites());
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }
}