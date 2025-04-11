import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/music_repository.dart';
import '../../models/album.dart';
import '../../models/track.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final MusicRepository repository;

  AlbumBloc(this.repository) : super(AlbumState.initial()) {
    on<LoadAlbumDetails>((event, emit) async {
      emit(state.copyWith(status: AlbumStatus.loading));
      try {
        final album = await repository.getAlbumDetails(event.albumId);
        final tracks = await repository.getTracksByAlbumId(event.albumId);

        if (album != null) {
          emit(state.copyWith(
            status: AlbumStatus.success,
            album: album,
            tracks: tracks,
          ));
        } else {
          emit(state.copyWith(status: AlbumStatus.failure));
        }
      } catch (_) {
        emit(state.copyWith(status: AlbumStatus.failure));
      }
    });
  }
}
