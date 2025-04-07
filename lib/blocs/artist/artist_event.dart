import 'package:equatable/equatable.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();
  
  @override
  List<Object> get props => [];
}

class LoadArtistDetails extends ArtistEvent {
  final String artistId;
  
  const LoadArtistDetails(this.artistId);
  
  @override
  List<Object> get props => [artistId];
}
