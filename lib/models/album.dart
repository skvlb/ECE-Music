import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Equatable {
  @JsonKey(name: 'idAlbum')
  final String id;
  
  @JsonKey(name: 'idArtist')
  final String artistId;
  
  @JsonKey(name: 'strAlbum')
  final String title;
  
  @JsonKey(name: 'strArtist')
  final String artistName;
  
  @JsonKey(name: 'intYearReleased')
  final String? yearReleased;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strAlbumThumb')
  final String? thumbUrl;
  
  @JsonKey(name: 'strAlbumCDart')
  final String? cdArtUrl;
  
  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEN;
  
  @JsonKey(name: 'strDescriptionFR')
  final String? descriptionFR;
  
  @JsonKey(name: 'intScore')
  final String? score;
  
  @JsonKey(name: 'intScoreVotes')
  final String? scoreVotes;

  const Album({
    required this.id,
    required this.artistId,
    required this.title,
    required this.artistName,
    this.yearReleased,
    this.genre,
    this.style,
    this.thumbUrl,
    this.cdArtUrl,
    this.descriptionEN,
    this.descriptionFR,
    this.score,
    this.scoreVotes,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  String getDescription(String locale) {
    if (locale.startsWith('fr') && descriptionFR != null && descriptionFR!.isNotEmpty) {
      return descriptionFR!;
    }
    return descriptionEN ?? '';
  }

  double? get scoreDouble => score != null ? double.tryParse(score!) : null;

  @override
  List<Object?> get props => [id, title, artistId];
}
