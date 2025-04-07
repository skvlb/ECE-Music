import 'package:equatable/equatable.dart';
import '../../models/artist.dart';
import '../../models/album.dart';

enum ArtistStatus { initial, loading, success, failure }

class ArtistState extends Equatable {
  final ArtistStatus status;
  final Artist? artist;
  final List<Album> albums;
  final String? errorMessage;
  
  const ArtistState({
    this.status = ArtistStatus.initial,
    this.artist,
    this.albums = const [],
    this.errorMessage,
  });
  
  ArtistState copyWith({
    ArtistStatus? status,
    Artist? artist,
    List<Album>? albums,
    String? errorMessage,
  }) {
    return ArtistState(
      status: status ?? this.status,
      artist: artist ?? this.artist,
      albums: albums ?? this.albums,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, artist, albums, errorMessage];
}