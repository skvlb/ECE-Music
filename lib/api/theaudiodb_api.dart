import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';

import '../models/album.dart';
import '../models/artist.dart';

part 'theaudiodb_api.g.dart';

@RestApi()
abstract class TheAudioDBAPI {
  factory TheAudioDBAPI(Dio dio, {@required String baseUrl}) = _TheAudioDBAPI;

  @GET('/mostloved.php?format=album')
  Future<AlbumResponse> getTopAlbums();

  @GET('/album.php')
  Future<AlbumResponse> getAlbumDetails(@Query('m') String artistId);

  @GET('/search.php')
  Future<ArtistResponse> getArtistDetails(@Query('s') String artistName);
}

class TheAudioDBManager {
  static TheAudioDBAPI? _instance;

  static TheAudioDBAPI getInstance() {
    _instance ??= TheAudioDBAPI(
      Dio(),
      baseUrl: 'https://theaudiodb.com/api/v1/json/2',
    );
    return _instance!;
  }
}
