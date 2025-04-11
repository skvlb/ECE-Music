import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import '../../repositories/music_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicRepository repository;

  SearchBloc(this.repository) : super(SearchState.initial()) {
    on<SearchArtistsAndAlbums>((event, emit) async {
      emit(state.copyWith(status: SearchStatus.loading));
      try {
        final artists = await repository.searchArtists(event.query);
        final albums = await repository.searchAlbums(event.query);
        emit(state.copyWith(
          status: SearchStatus.success,
          artists: artists,
          albums: albums,
        ));
      } catch (_) {
        emit(state.copyWith(status: SearchStatus.failure));
      }
    });
  }
}
