// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String,
      artistId: json['idArtist'] as String,
      title: json['strAlbum'] as String,
      artistName: json['strArtist'] as String,
      yearReleased: json['intYearReleased'] as String?,
      genre: json['strGenre'] as String?,
      style: json['strStyle'] as String?,
      thumbUrl: json['strAlbumThumb'] as String?,
      cdArtUrl: json['strAlbumCDart'] as String?,
      descriptionEN: json['strDescriptionEN'] as String?,
      descriptionFR: json['strDescriptionFR'] as String?,
      score: json['intScore'] as String?,
      scoreVotes: json['intScoreVotes'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'idArtist': instance.artistId,
      'strAlbum': instance.title,
      'strArtist': instance.artistName,
      'intYearReleased': instance.yearReleased,
      'strGenre': instance.genre,
      'strStyle': instance.style,
      'strAlbumThumb': instance.thumbUrl,
      'strAlbumCDart': instance.cdArtUrl,
      'strDescriptionEN': instance.descriptionEN,
      'strDescriptionFR': instance.descriptionFR,
      'intScore': instance.score,
      'intScoreVotes': instance.scoreVotes,
    };
