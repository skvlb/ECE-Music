import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/music_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicRepository _musicRepository;
  
  SearchBloc(this._musicRepository) : super(const SearchState()) {
    on<SearchArtistsAndAlbums>(_onSearchArtistsAndAlbums);
    on<ClearSearch>(_onClearSearch);
  }
  
  Future<void> _onSearchArtistsAndAlbums(
    SearchArtistsAndAlbums event, 
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    
    if (query.isEmpty) {
      emit(const SearchState());
      return;
    }
    
    emit(SearchState(
      status: SearchStatus.loading,
      query: query,
    ));
    
    try {
      final artists = await _musicRepository.searchArtists(query);
      final albums = await _musicRepository.searchAlbums(query);
      
      emit(SearchState(
        status: SearchStatus.success,
        query: query,
        artists: artists,
        albums: albums,
      ));
    } catch (e) {
      emit(SearchState(
        status: SearchStatus.failure,
        query: query,
        errorMessage: e.toString(),
      ));
    }
  }
  
  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}