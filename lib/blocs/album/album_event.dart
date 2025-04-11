// lib/blocs/album/album_event.dart
abstract class AlbumEvent {}

class LoadAlbumDetails extends AlbumEvent {
  final String albumId;

  LoadAlbumDetails(this.albumId);
}