import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/music_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final MusicRepository _musicRepository;
  
  AlbumBloc(this._musicRepository) : super(const AlbumState()) {
    on<LoadAlbumDetails>(_onLoadAlbumDetails);
  }
  
  Future<void> _onLoadAlbumDetails(
    LoadAlbumDetails event, 
    Emitter<AlbumState> emit,
  ) async {
    emit(const AlbumState(status: AlbumStatus.loading));
    
    try {
      final album = await _musicRepository.getAlbumDetails(event.albumId);
      final tracks = await _musicRepository.getAlbumTracks(event.albumId);
      
      emit(AlbumState(
        status: AlbumStatus.success,
        album: album,
        tracks: tracks,
      ));
    } catch (e) {
      emit(AlbumState(
        status: AlbumStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}