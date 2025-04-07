// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['idArtist'] as String,
      name: json['strArtist'] as String,
      genre: json['strGenre'] as String?,
      style: json['strStyle'] as String?,
      country: json['strCountry'] as String?,
      biographyEN: json['strBiographyEN'] as String?,
      biographyFR: json['strBiographyFR'] as String?,
      thumbUrl: json['strArtistThumb'] as String?,
      bannerUrl: json['strArtistBanner'] as String?,
      fanartUrl: json['strArtistFanart'] as String?,
      fanart2Url: json['strArtistFanart2'] as String?,
      logoUrl: json['strArtistLogo'] as String?,
      website: json['strWebsite'] as String?,
      facebook: json['strFacebook'] as String?,
      twitter: json['strTwitter'] as String?,
      formationYear: json['strFormationYear'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.name,
      'strGenre': instance.genre,
      'strStyle': instance.style,
      'strCountry': instance.country,
      'strBiographyEN': instance.biographyEN,
      'strBiographyFR': instance.biographyFR,
      'strArtistThumb': instance.thumbUrl,
      'strArtistBanner': instance.bannerUrl,
      'strArtistFanart': instance.fanartUrl,
      'strArtistFanart2': instance.fanart2Url,
      'strArtistLogo': instance.logoUrl,
      'strWebsite': instance.website,
      'strFacebook': instance.facebook,
      'strTwitter': instance.twitter,
      'strFormationYear': instance.formationYear,
    };
