import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;
  final VoidCallback onTap;
  
  const ArtistTile({
    super.key,
    required this.artist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: artist.thumbUrl != null
          ? CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(artist.thumbUrl!),
              radius: 25,
            )
          : CircleAvatar(
              backgroundColor: Colors.grey[850],
              child: const Icon(Icons.person),
              radius: 25,
            ),
      title: Text(artist.name),
      subtitle: artist.genre != null
          ? Text(artist.genre!)
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}