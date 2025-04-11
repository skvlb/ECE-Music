import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../models/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;

  const ArtistTile({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: artist.strArtistThumb != null
          ? CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(artist.strArtistThumb!),
        radius: 25,
      )
          : const CircleAvatar(
        child: Icon(Icons.person),
        radius: 25,
      ),
      title: Text(artist.strArtist),
      subtitle: artist.strGenre != null ? Text(artist.strGenre!) : null,
      onTap: () {
        if (artist.id != null) {
          GoRouter.of(context).go('/artist/${artist.id}');
        } else {
          debugPrint('Artist ID is null');
        }
      },
    );
  }
}
