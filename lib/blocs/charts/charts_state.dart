import 'package:equatable/equatable.dart';
import '../../models/track.dart';
import '../../models/album.dart';

enum ChartsStatus { initial, loading, success, failure }

class ChartsState extends Equatable {
  final ChartsStatus status;
  final List<Track> singles;
  final List<Album> albums;
  final String? errorMessage;
  
  const ChartsState({
    this.status = ChartsStatus.initial,
    this.singles = const [],
    this.albums = const [],
    this.errorMessage,
  });
  
  ChartsState copyWith({
    ChartsStatus? status,
    List<Track>? singles,
    List<Album>? albums,
    String? errorMessage,
  }) {
    return ChartsState(
      status: status ?? this.status,
      singles: singles ?? this.singles,
      albums: albums ?? this.albums,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, singles, albums, errorMessage];
}
