import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback onTap;
  final int? rank;
  final bool showArtist;
  final bool showAlbum;
  
  const TrackTile({
    super.key,
    required this.track,
    required this.onTap,
    this.rank,
    this.showArtist = true,
    this.showAlbum = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: rank != null
          ? SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          : track.thumbUrl != null
              ? CachedNetworkImage(
                  imageUrl: track.thumbUrl!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[850],
                    width: 40,
                    height: 40,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[850],
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.music_note),
                  ),
                )
              : null,
      title: Text(track.title),
      subtitle: showArtist
          ? Text(track.artistName + (showAlbum ? ' • ${track.albumTitle}' : ''))
          : showAlbum
              ? Text(track.albumTitle)
              : track.durationFormatted.isNotEmpty
                  ? Text(track.durationFormatted)
                  : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}