import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/music_repository.dart';
import 'charts_event.dart';
import 'charts_state.dart';

class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final MusicRepository _musicRepository;
  
  ChartsBloc(this._musicRepository) : super(const ChartsState()) {
    on<LoadCharts>(_onLoadCharts);
    on<RefreshCharts>(_onRefreshCharts);
  }
  
  Future<void> _onLoadCharts(LoadCharts event, Emitter<ChartsState> emit) async {
    if (state.status == ChartsStatus.loading) return;
    
    emit(state.copyWith(status: ChartsStatus.loading));
    
    try {
      final singles = await _musicRepository.getTrendingSingles();
      final albums = await _musicRepository.getTrendingAlbums();
      
      emit(state.copyWith(
        status: ChartsStatus.success,
        singles: singles,
        albums: albums,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChartsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
  
  Future<void> _onRefreshCharts(RefreshCharts event, Emitter<ChartsState> emit) async {
    emit(state.copyWith(status: ChartsStatus.loading));
    
    try {
      final singles = await _musicRepository.getTrendingSingles();
      final albums = await _musicRepository.getTrendingAlbums();
      
      emit(state.copyWith(
        status: ChartsStatus.success,
        singles: singles,
        albums: albums,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChartsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}