import 'package:flutter_bloc/flutter_bloc.dart';
import 'artist_event.dart';
import 'artist_state.dart';
import '../../repositories/music_repository.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final MusicRepository repository;

  ArtistBloc(this.repository) : super(ArtistState.initial()) {
    on<LoadArtistDetails>((event, emit) async {
      emit(state.copyWith(status: ArtistStatus.loading));
      try {
        final artist = await repository.getArtistDetails(event.artistId);
        final artistAlbums = await repository.getArtistAlbums(event.artistId);

        emit(state.copyWith(
          status: ArtistStatus.success,
          artist: artist.isNotEmpty ? artist.first : null,
          albums: artistAlbums,
        ));
      } catch (_) {
        emit(state.copyWith(status: ArtistStatus.failure));
      }
    });


  }
}
