// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['idTrack'] as String,
      albumId: json['idAlbum'] as String,
      artistId: json['idArtist'] as String,
      title: json['strTrack'] as String,
      artistName: json['strArtist'] as String,
      albumTitle: json['strAlbum'] as String,
      thumbUrl: json['strTrackThumb'] as String?,
      trackNumber: json['intTrackNumber'] as String?,
      duration: json['intDuration'] as String?,
      musicVideoUrl: json['strMusicVid'] as String?,
      descriptionEN: json['strDescriptionEN'] as String?,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'idTrack': instance.id,
      'idAlbum': instance.albumId,
      'idArtist': instance.artistId,
      'strTrack': instance.title,
      'strArtist': instance.artistName,
      'strAlbum': instance.albumTitle,
      'strTrackThumb': instance.thumbUrl,
      'intTrackNumber': instance.trackNumber,
      'intDuration': instance.duration,
      'strMusicVid': instance.musicVideoUrl,
      'strDescriptionEN': instance.descriptionEN,
    };

TrackResponse _$TrackResponseFromJson(Map<String, dynamic> json) =>
    TrackResponse(
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackResponseToJson(TrackResponse instance) =>
    <String, dynamic>{
      'track': instance.track,
    };
