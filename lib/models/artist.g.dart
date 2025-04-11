// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['idArtist'] as String,
      strArtist: json['strArtist'] as String,
      strArtistThumb: json['strArtistThumb'] as String?,
      strBiographyEN: json['strBiographyEN'] as String?,
      strBiographyFR: json['strBiographyFR'] as String?,
      strGenre: json['strGenre'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.strArtist,
      'strArtistThumb': instance.strArtistThumb,
      'strBiographyEN': instance.strBiographyEN,
      'strBiographyFR': instance.strBiographyFR,
      'strGenre': instance.strGenre,
    };

ArtistResponse _$ArtistResponseFromJson(Map<String, dynamic> json) =>
    ArtistResponse(
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistResponseToJson(ArtistResponse instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
