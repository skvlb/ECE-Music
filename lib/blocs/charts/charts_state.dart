import '../../models/album.dart';
import '../../models/track.dart';

enum ChartsStatus { initial, loading, success, failure }

class ChartsState {
  final ChartsStatus status;
  final List<Album> topAlbums;
  final List<Track> topTracks;

  ChartsState({
    required this.status,
    required this.topAlbums,
    required this.topTracks,
  });

  factory ChartsState.initial() => ChartsState(
    status: ChartsStatus.initial,
    topAlbums: [],
    topTracks: [],
  );

  ChartsState copyWith({
    ChartsStatus? status,
    List<Album>? topAlbums,
    List<Track>? topTracks,
  }) {
    return ChartsState(
      status: status ?? this.status,
      topAlbums: topAlbums ?? this.topAlbums,
      topTracks: topTracks ?? this.topTracks,
    );
  }
}
