import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/album.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;
  
  const AlbumTile({
    super.key,
    required this.album,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: album.thumbUrl != null
            ? CachedNetworkImage(
                imageUrl: album.thumbUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[850],
                  width: 50,
                  height: 50,
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[850],
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.album),
                ),
              )
            : Container(
                color: Colors.grey[850],
                width: 50,
                height: 50,
                child: const Icon(Icons.album),
              ),
      ),
      title: Text(album.title),
      subtitle: Text(album.artistName),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
