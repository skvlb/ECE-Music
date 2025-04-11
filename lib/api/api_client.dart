import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/523532/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// Recherche par nom d'artiste (ex: Coldplay)
  @GET("search.php")
  Future<ArtistResponse> searchArtist(@Query("s") String artistName);

  /// Détails d'un artiste via son ID
  @GET("artist.php")
  Future<ArtistResponse> getArtistDetails(@Query("i") String artistId);

  /// Recherche des albums d'un artiste par nom
  @GET("searchalbum.php")
  Future<AlbumResponse> searchAlbum(@Query("s") String artistName);

  /// Détails d'un album via son ID
  @GET("album.php")
  Future<AlbumResponse> getAlbumDetails(@Query("m") String albumId);

  @GET("mostloved.php?format=album")
  Future<AlbumResponse> getTopAlbums();

  @GET('album.php')
  Future<AlbumResponse> getAlbumsByArtistId(@Query('i') String artistId);

  @GET("track.php")
  Future<TrackResponse> getTracksByAlbumId(@Query("m") String albumId);
}
