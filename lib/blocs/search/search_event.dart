abstract class SearchEvent {}

class SearchArtistsAndAlbums extends SearchEvent {
  final String query;

  SearchArtistsAndAlbums(this.query);
}
