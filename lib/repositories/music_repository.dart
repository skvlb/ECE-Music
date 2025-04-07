import '../api/api_service.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';

class MusicRepository {
  final ApiService _apiService = ApiService();
  
  // Recherche
  Future<List<Artist>> searchArtists(String query) async {
    if (query.isEmpty) return [];
    return _apiService.searchArtists(query);
  }
  
  Future<List<Album>> searchAlbums(String query) async {
    if (query.isEmpty) return [];
    return _apiService.searchAlbums(query);
  }
  
  // Détails de l'artiste
  Future<Artist> getArtistDetails(String artistId) async {
    return _apiService.getArtistDetails(artistId);
  }
  
  // Albums d'un artiste
  Future<List<Album>> getArtistAlbums(String artistId) async {
    return _apiService.getArtistAlbums(artistId);
  }
  
  // Détails d'un album
  Future<Album> getAlbumDetails(String albumId) async {
    return _apiService.getAlbumDetails(albumId);
  }
  
  // Titres d'un album
  Future<List<Track>> getAlbumTracks(String albumId) async {
    return _apiService.getAlbumTracks(albumId);
  }
  
  // Classements iTunes
  Future<List<Track>> getTrendingSingles() async {
    return _apiService.getTrendingSingles();
  }
  
  Future<List<Album>> getTrendingAlbums() async {
    return _apiService.getTrendingAlbums();
  }
}