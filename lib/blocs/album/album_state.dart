import '../../models/album.dart';
import '../../models/track.dart';

enum AlbumStatus { initial, loading, success, failure }

class AlbumState {
  final AlbumStatus status;
  final Album? album;
  final List<Track> tracks;

  AlbumState({
    required this.status,
    this.album,
    this.tracks = const [],
  });

  factory AlbumState.initial() => AlbumState(status: AlbumStatus.initial);

  AlbumState copyWith({
    AlbumStatus? status,
    Album? album,
    List<Track>? tracks,
  }) {
    return AlbumState(
      status: status ?? this.status,
      album: album ?? this.album,
      tracks: tracks ?? this.tracks,
    );
  }
}
