import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/music_repository.dart';
import 'artist_event.dart';
import 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final MusicRepository _musicRepository;
  
  ArtistBloc(this._musicRepository) : super(const ArtistState()) {
    on<LoadArtistDetails>(_onLoadArtistDetails);
  }
  
  Future<void> _onLoadArtistDetails(
    LoadArtistDetails event, 
    Emitter<ArtistState> emit,
  ) async {
    emit(const ArtistState(status: ArtistStatus.loading));
    
    try {
      final artist = await _musicRepository.getArtistDetails(event.artistId);
      final albums = await _musicRepository.getArtistAlbums(event.artistId);
      
      emit(ArtistState(
        status: ArtistStatus.success,
        artist: artist,
        albums: albums,
      ));
    } catch (e) {
      emit(ArtistState(
        status: ArtistStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
