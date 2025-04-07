import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist extends Equatable {
  @JsonKey(name: 'idArtist')
  final String id;
  
  @JsonKey(name: 'strArtist')
  final String name;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strCountry')
  final String? country;
  
  @JsonKey(name: 'strBiographyEN')
  final String? biographyEN;
  
  @JsonKey(name: 'strBiographyFR')
  final String? biographyFR;
  
  @JsonKey(name: 'strArtistThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'strArtistBanner')
  final String? bannerUrl;
  
  @JsonKey(name: 'strArtistFanart')
  final String? fanartUrl;
  
  @JsonKey(name: 'strArtistFanart2')
  final String? fanart2Url;
  
  @JsonKey(name: 'strArtistLogo')
  final String? logoUrl;
  
  @JsonKey(name: 'strWebsite')
  final String? website;
  
  @JsonKey(name: 'strFacebook')
  final String? facebook;
  
  @JsonKey(name: 'strTwitter')
  final String? twitter;
  
  @JsonKey(name: 'strFormationYear')
  final String? formationYear;

  const Artist({
    required this.id,
    required this.name,
    this.genre,
    this.style,
    this.country,
    this.biographyEN,
    this.biographyFR,
    this.thumbUrl,
    this.bannerUrl,
    this.fanartUrl,
    this.fanart2Url,
    this.logoUrl,
    this.website,
    this.facebook,
    this.twitter,
    this.formationYear,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  String getBiography(String locale) {
    if (locale.startsWith('fr') && biographyFR != null && biographyFR!.isNotEmpty) {
      return biographyFR!;
    }
    return biographyEN ?? '';
  }

  @override
  List<Object?> get props => [id, name];
}
