import 'package:equatable/equatable.dart';
import '../../models/album.dart';
import '../../models/track.dart';

enum AlbumStatus { initial, loading, success, failure }

class AlbumState extends Equatable {
  final AlbumStatus status;
  final Album? album;
  final List<Track> tracks;
  final String? errorMessage;
  
  const AlbumState({
    this.status = AlbumStatus.initial,
    this.album,
    this.tracks = const [],
    this.errorMessage,
  });
  
  AlbumState copyWith({
    AlbumStatus? status,
    Album? album,
    List<Track>? tracks,
    String? errorMessage,
  }) {
    return AlbumState(
      status: status ?? this.status,
      album: album ?? this.album,
      tracks: tracks ?? this.tracks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, album, tracks, errorMessage];
}