abstract class ArtistEvent {}

class LoadArtistDetails extends ArtistEvent {
  final String artistId;

  LoadArtistDetails(this.artistId);
}
