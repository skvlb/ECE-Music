import 'package:hive/hive.dart';

part 'favorites.g.dart';

@HiveType(typeId: 0)
class FavoriteArtist extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String? thumbUrl;
  
  @HiveField(3)
  final String? genre;

  FavoriteArtist({
    required this.id,
    required this.name,
    this.thumbUrl,
    this.genre,
  });
}