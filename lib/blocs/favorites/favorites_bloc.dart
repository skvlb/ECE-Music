import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../repositories/favorites_repository.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesState.initial()) {
    on<LoadFavorites>((event, emit) {
      final ids = repository.getFavoriteIds();
      emit(state.copyWith(status: FavoritesStatus.success, favoriteIds: ids));
    });

    on<ToggleFavorite>((event, emit) {
      repository.toggleFavorite(event.artistId);
      final updated = repository.getFavoriteIds();
      emit(state.copyWith(favoriteIds: updated));
    });
  }
}
