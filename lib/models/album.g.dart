// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String,
      strAlbum: json['strAlbum'] as String,
      strArtist: json['strArtist'] as String,
      strAlbumThumb: json['strAlbumThumb'] as String?,
      strDescriptionEN: json['strDescriptionEN'] as String?,
      strDescriptionFR: json['strDescriptionFR'] as String?,
      strGenre: json['strGenre'] as String?,
      intYearReleased: json['intYearReleased'] as String?,
      intScore: json['intScore'] as String?,
      intScoreVotes: json['intScoreVotes'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'strAlbum': instance.strAlbum,
      'strAlbumThumb': instance.strAlbumThumb,
      'strArtist': instance.strArtist,
      'strDescriptionEN': instance.strDescriptionEN,
      'strDescriptionFR': instance.strDescriptionFR,
      'strGenre': instance.strGenre,
      'intYearReleased': instance.intYearReleased,
      'intScore': instance.intScore,
      'intScoreVotes': instance.intScoreVotes,
    };

AlbumResponse _$AlbumResponseFromJson(Map<String, dynamic> json) =>
    AlbumResponse(
      album: (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumResponseToJson(AlbumResponse instance) =>
    <String, dynamic>{
      'album': instance.album,
    };
