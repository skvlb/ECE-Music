import '../../models/artist.dart';
import '../../models/album.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final SearchStatus status;
  final List<Artist> artists;
  final List<Album> albums;

  SearchState({required this.status, required this.artists, required this.albums});

  factory SearchState.initial() =>
      SearchState(status: SearchStatus.initial, artists: [], albums: []);

  SearchState copyWith({
    SearchStatus? status,
    List<Artist>? artists,
    List<Album>? albums,
  }) {
    return SearchState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
    );
  }
}
