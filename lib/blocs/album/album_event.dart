import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
  
  @override
  List<Object> get props => [];
}

class LoadAlbumDetails extends AlbumEvent {
  final String albumId;
  
  const LoadAlbumDetails(this.albumId);
  
  @override
  List<Object> get props => [albumId];
}
