import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  @JsonKey(name: 'idAlbum')
  final String id;

  @JsonKey(name: 'strAlbum')
  final String strAlbum;

  @JsonKey(name: 'strAlbumThumb')
  final String? strAlbumThumb;

  @JsonKey(name: 'strArtist')
  final String strArtist;

  @JsonKey(name: 'strDescriptionEN')
  final String? strDescriptionEN;

  @JsonKey(name: 'strDescriptionFR')
  final String? strDescriptionFR;

  @JsonKey(name: 'strGenre')
  final String? strGenre;

  @JsonKey(name: 'intYearReleased')
  final String? intYearReleased;

  @JsonKey(name: 'intScore')
  final String? intScore;

  @JsonKey(name: 'intScoreVotes')
  final String? intScoreVotes;


  Album({
    required this.id,
    required this.strAlbum,
    required this.strArtist,
    this.strAlbumThumb,
    this.strDescriptionEN,
    this.strDescriptionFR,
    this.strGenre,
    this.intYearReleased,
    this.intScore,
    this.intScoreVotes,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class AlbumResponse {
  final List<Album>? album;

  AlbumResponse({this.album});

  factory AlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);

}

