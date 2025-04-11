import 'package:flutter_bloc/flutter_bloc.dart';
import 'charts_event.dart';
import 'charts_state.dart';
import '../../repositories/music_repository.dart';

class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final MusicRepository repository;

  ChartsBloc(this.repository) : super(ChartsState.initial()) {
    on<LoadTopAlbums>((event, emit) async {
      emit(state.copyWith(status: ChartsStatus.loading));
      try {
        final albums = await repository.getTopAlbums(); // À adapter
        emit(state.copyWith(
          status: ChartsStatus.success,
          topAlbums: albums,
        ));
      } catch (_) {
        emit(state.copyWith(status: ChartsStatus.failure));
      }
    });

    on<LoadTopTracks>((event, emit) async {
      emit(state.copyWith(status: ChartsStatus.loading));
      try {
        final tracks = await repository.getTopTracks(); // À créer
        emit(state.copyWith(
          status: ChartsStatus.success,
          topTracks: tracks,
        ));
      } catch (_) {
        emit(state.copyWith(status: ChartsStatus.failure));
      }
    });
  }
}
