import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/album.dart';

class AlbumTile extends StatelessWidget {
  final Album album;

  const AlbumTile({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: album.strAlbumThumb != null
          ? CachedNetworkImage(
        imageUrl: album.strAlbumThumb!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      )
          : const Icon(Icons.album, size: 50),
      title: Text(album.strAlbum),
      subtitle: Text(album.strArtist ?? ''),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (album.id != null) {
          GoRouter.of(context).go('/album/2115886');
        }
      },
    );
  }
}
