import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/523532")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  
  // Rechercher un artiste
  @GET("/search.php")
  Future<ArtistResponse> searchArtist(@Query("s") String artistName);
  
  // Rechercher un album
  @GET("/searchalbum.php")
  Future<AlbumResponse> searchAlbum(@Query("s") String albumName);
  
  // Obtenir les détails d'un artiste par ID
  @GET("/artist.php")
  Future<ArtistResponse> getArtistById(@Query("i") String artistId);
  
  // Obtenir les albums d'un artiste
  @GET("/album.php")
  Future<AlbumResponse> getArtistAlbums(@Query("i") String artistId);
  
  // Obtenir les titres d'un album
  @GET("/track.php")
  Future<TrackResponse> getAlbumTracks(@Query("m") String albumId);
  
  // Obtenir les détails d'un album
  @GET("/album.php")
  Future<AlbumResponse> getAlbumById(@Query("m") String albumId);
  
  // Obtenir les singles classés dans le TOP iTunes US
  @GET("/trending.php")
  Future<TrackResponse> getTrendingSingles(@Query("country") String country, @Query("type") String type);
  
  // Obtenir les albums classés dans le TOP iTunes US
  @GET("/trending.php")
  Future<AlbumResponse> getTrendingAlbums(@Query("country") String country, @Query("type") String type);
}

// Classe de réponse pour les artistes
class ArtistResponse {
  final List<Artist> artists;
  
  ArtistResponse({required this.artists});
  
  factory ArtistResponse.fromJson(Map<String, dynamic> json) {
    final artistsList = json['artists'] as List<dynamic>?;
    if (artistsList == null) {
      return ArtistResponse(artists: []);
    }
    return ArtistResponse(
      artists: artistsList.map((e) => Artist.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

// Classe de réponse pour les albums
class AlbumResponse {
  final List<Album> albums;
  
  AlbumResponse({required this.albums});
  
  factory AlbumResponse.fromJson(Map<String, dynamic> json) {
    final albumsList = json['album'] as List<dynamic>?;
    if (albumsList == null) {
      return AlbumResponse(albums: []);
    }
    return AlbumResponse(
      albums: albumsList.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

// Classe de réponse pour les titres
class TrackResponse {
  final List<Track> tracks;
  
  TrackResponse({required this.tracks});
  
  factory TrackResponse.fromJson(Map<String, dynamic> json) {
    final tracksList = json['track'] as List<dynamic>?;
    if (tracksList == null) {
      return TrackResponse(tracks: []);
    }
    return TrackResponse(
      tracks: tracksList.map((e) => Track.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}