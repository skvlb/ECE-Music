import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'track.g.dart';

@JsonSerializable()
class Track extends Equatable {
  @JsonKey(name: 'idTrack')
  final String id;
  
  @JsonKey(name: 'idAlbum')
  final String albumId;
  
  @JsonKey(name: 'idArtist')
  final String artistId;
  
  @JsonKey(name: 'strTrack')
  final String title;
  
  @JsonKey(name: 'strArtist')
  final String artistName;
  
  @JsonKey(name: 'strAlbum')
  final String albumTitle;
  
  @JsonKey(name: 'strTrackThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'intTrackNumber')
  final String? trackNumber;
  
  @JsonKey(name: 'intDuration')
  final String? duration;
  
  @JsonKey(name: 'strMusicVid')
  final String? musicVideoUrl;
  
  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEN;

  const Track({
    required this.id,
    required this.albumId,
    required this.artistId,
    required this.title,
    required this.artistName,
    required this.albumTitle,
    this.thumbUrl,
    this.trackNumber,
    this.duration,
    this.musicVideoUrl,
    this.descriptionEN,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  int get trackNumberInt => int.tryParse(trackNumber ?? '0') ?? 0;

  String get durationFormatted {
    if (duration == null) return '';
    
    final durationInSeconds = int.tryParse(duration!) ?? 0;
    final minutes = (durationInSeconds / 60).floor();
    final seconds = durationInSeconds % 60;
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [id, title, artistId, albumId];
}