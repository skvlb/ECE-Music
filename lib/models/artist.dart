import 'package:json_annotation/json_annotation.dart';
import '../models/artist.dart';
part 'artist.g.dart';

@JsonSerializable()
class Artist {
  @JsonKey(name: 'idArtist')
  final String id;

  @JsonKey(name: 'strArtist')
  final String strArtist;

  @JsonKey(name: 'strArtistThumb')
  final String? strArtistThumb;

  @JsonKey(name: 'strBiographyEN')
  final String? strBiographyEN;

  @JsonKey(name: 'strBiographyFR')
  final String? strBiographyFR;

  @JsonKey(name: 'strGenre')
  final String? strGenre;

  Artist({
    required this.id,
    required this.strArtist,
    this.strArtistThumb,
    this.strBiographyEN,
    this.strBiographyFR,
    this.strGenre,
  });

  factory Artist.fromJson(Map<String, dynamic> json) =>
      _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class ArtistResponse {
  final List<Artist>? artists;

  ArtistResponse({this.artists});

  factory ArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}
