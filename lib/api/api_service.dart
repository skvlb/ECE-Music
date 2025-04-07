import 'package:dio/dio.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';
import 'api_client.dart';

class ApiService {
  late final ApiClient _apiClient;
  
  ApiService() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    
    _apiClient = ApiClient(dio);
  }
  
  // Recherche d'artistes
  Future<List<Artist>> searchArtists(String query) async {
    try {
      final response = await _apiClient.searchArtist(query);
      return response.artists;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Recherche d'albums
  Future<List<Album>> searchAlbums(String query) async {
    try {
      final response = await _apiClient.searchAlbum(query);
      return response.albums;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir les détails d'un artiste
  Future<Artist> getArtistDetails(String artistId) async {
    try {
      final response = await _apiClient.getArtistById(artistId);
      if (response.artists.isEmpty) {
        throw Exception('Artiste non trouvé');
      }
      return response.artists.first;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir les albums d'un artiste
  Future<List<Album>> getArtistAlbums(String artistId) async {
    try {
      final response = await _apiClient.getArtistAlbums(artistId);
      return response.albums;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir les détails d'un album
  Future<Album> getAlbumDetails(String albumId) async {
    try {
      final response = await _apiClient.getAlbumById(albumId);
      if (response.albums.isEmpty) {
        throw Exception('Album non trouvé');
      }
      return response.albums.first;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir les titres d'un album
  Future<List<Track>> getAlbumTracks(String albumId) async {
    try {
      final response = await _apiClient.getAlbumTracks(albumId);
      return response.tracks;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir le TOP iTunes Singles US
  Future<List<Track>> getTrendingSingles() async {
    try {
      final response = await _apiClient.getTrendingSingles('us', 'itunes');
      return response.tracks;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Obtenir le TOP iTunes Albums US
  Future<List<Album>> getTrendingAlbums() async {
    try {
      final response = await _apiClient.getTrendingAlbums('us', 'itunes');
      return response.albums;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Gestion des erreurs
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Timeout de la connexion. Veuillez réessayer.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 404) {
            return Exception('Ressource non trouvée');
          }
          return Exception('Erreur serveur (${statusCode})');
        case DioExceptionType.connectionError:
          return Exception('Pas de connexion Internet');
        default:
          return Exception('Erreur de connexion');
      }
    }
    return Exception('Une erreur est survenue');
  }
}