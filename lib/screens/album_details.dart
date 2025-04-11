import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/album.dart';
import '../models/track.dart';
import '../repositories/music_repository.dart';
import '../blocs/album/album_bloc.dart';
import '../blocs/album/album_state.dart';
import '../blocs/album/album_event.dart';

import '../constants/app_icons.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final String albumId;

  const AlbumDetailsScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AlbumBloc>(context)..add(LoadAlbumDetails(albumId)),
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state.status == AlbumStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state.status == AlbumStatus.failure || state.album == null) {
            return const Scaffold(body: Center(child: Text('Erreur de chargement')));
          }

          final album = state.album!;
          final favoritesBox = Hive.box<String>('favorites');

          return Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder<List<Track>>(
              future: context.read<MusicRepository>().getTracksByAlbumId(album.id),
              builder: (context, snapshot) {
                final tracks = snapshot.data ?? [];

                return ListView(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if (album.strAlbumThumb != null)
                              CachedNetworkImage(
                                imageUrl: album.strAlbumThumb!,
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            Positioned(
                              left: 16,
                              bottom: 30,
                              right: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    album.strArtist,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    album.strAlbum,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SFPro',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${tracks.length} chanson${tracks.length > 1 ? 's' : ''}',
                                    style: const TextStyle(color: Colors.white70),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
IconButton(
  icon: AppIcons.flecheGauche(color: Colors.white),
  onPressed: () => context.go('/'),
),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    bool isFavorited = favoritesBox.containsKey('album_${album.id}');
                                    return GestureDetector(
                                      onTap: () {
                                        if (isFavorited) {
                                          favoritesBox.delete('album_${album.id}');
                                        } else {
                                          favoritesBox.put('album_${album.id}', album.strAlbum);
                                        }
                                        setState(() {
                                          isFavorited = !isFavorited;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isFavorited ? Icons.favorite : Icons.favorite_border,
                                          color: isFavorited ? Colors.green : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
  children: [
    AppIcons.etoile(color: Colors.amber),
    const SizedBox(width: 8),
    Text(
      album.intScore ?? '4.0',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
                                const SizedBox(width: 12),
                                Text('${album.intScoreVotes ?? '323'} votes'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (album.strDescriptionEN != null)
                            Text(
                              album.strDescriptionEN!,
                              style: const TextStyle(color: Colors.black87),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const SizedBox(height: 20),
                          const Text(
                            'Titres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SFPro',
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...tracks.take(7).toList().asMap().entries.map((entry) {
                            final i = entry.key;
                            final track = entry.value;
                            return Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  leading: Text('${i + 1}',
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                  title: Text(track.title),
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
