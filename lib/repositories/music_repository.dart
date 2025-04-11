import '../api/api_client.dart';
import '../models/album.dart';
import '../models/artist.dart';
import '../api/api_service.dart';
import '../models/track.dart';
import 'package:dio/dio.dart';

class MusicRepository {
  final Dio _dio = Dio(); // Ajouté ici
  final ApiClient api;

  MusicRepository({ApiClient? api})
      : api = api ?? ApiService.apiClient;

  Future<List<Artist>> getArtistDetails(String artistId) async {
    final response = await api.getArtistDetails(artistId);
    return response.artists ?? [];
  }

  Future<List<Album>> getArtistAlbums(String artistId) async {
    final response = await api.getAlbumsByArtistId(artistId);
    return response.album ?? [];
  }

  Future<List<Album>> searchAlbums(String query) async {
    final response = await api.searchAlbum(query);
    return response.album ?? [];
  }

  Future<List<Artist>> searchArtists(String query) async {
    final response = await api.searchArtist(query);
    return response.artists ?? [];
  }

  Future<List<Album>> getTopAlbums() async {
    final response = await _dio.get('https://theaudiodb.com/api/v1/json/523532/trending.php?country=us&type=album&format=albums');
    final data = response.data['trending'];
    return data.map<Album>((json) => Album.fromJson(json)).toList();
  }

  Future<Album?> getAlbumDetails(String albumId) async {
    final response = await api.getAlbumDetails(albumId);
    return response.album?.isNotEmpty == true ? response.album!.first : null;
  }

  Future<List<Track>> getTracksByAlbumId(String albumId) async {
    final response = await api.getTracksByAlbumId(albumId);
    return response.track ?? [];
  }
  Future<List<Track>> getTopTracks() async {
    final response = await _dio.get('https://theaudiodb.com/api/v1/json/523532/mostloved.php?format=track');
    final List<dynamic> data = response.data['loved'];
    return data.map((json) => Track.fromJson(json)).toList();
  }

}
