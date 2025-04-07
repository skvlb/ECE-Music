import 'package:equatable/equatable.dart';
import '../../models/artist.dart';
import '../../models/album.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final String query;
  final List<Artist> artists;
  final List<Album> albums;
  final String? errorMessage;
  
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.artists = const [],
    this.albums = const [],
    this.errorMessage,
  });
  
  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Artist>? artists,
    List<Album>? albums,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, query, artists, albums, errorMessage];
}