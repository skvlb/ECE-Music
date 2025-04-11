import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/artist.dart';
import '../models/track.dart';
import '../repositories/music_repository.dart';
import '../blocs/artist/artist_bloc.dart';
import '../blocs/artist/artist_state.dart';
import '../blocs/artist/artist_event.dart';

class ArtistDetailsScreen extends StatelessWidget {
  final String artistId;

  const ArtistDetailsScreen({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ArtistBloc>(context)..add(LoadArtistDetails(artistId)),
      child: BlocBuilder<ArtistBloc, ArtistState>(
        builder: (context, state) {
          if (state.status == ArtistStatus.loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state.status == ArtistStatus.failure || state.artist == null) {
            return const Scaffold(body: Center(child: Text('Erreur de chargement')));
          }

          final artist = state.artist!;
          final albums = state.albums;

          final favoritesBox = Hive.box<String>('favorites');

          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                Stack(
                  children: [
                    // FULL COVER IMAGE
                    if (artist.strArtistThumb != null)
                      CachedNetworkImage(
                        imageUrl: artist.strArtistThumb!,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    // TOP BAR
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                              onPressed: () => context.go('/'),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                bool isFavorited = favoritesBox.containsKey('artist_${artist.id}');
                                return GestureDetector(
                                  onTap: () {
                                    if (isFavorited) {
                                      favoritesBox.delete('artist_${artist.id}');
                                    } else {
                                      favoritesBox.put('artist_${artist.id}', artist.strArtist);
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
                    // ARTIST NAME OVER IMAGE
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artist.strArtist,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${artist.strGenre ?? ""}${artist.strGenre != null ? " • " : ""}Toronto, Canada',
                            style: const TextStyle(color: Colors.white70),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                // BIO + ALBUMS + SONGS
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BIO SHORTENED
                      if (artist.strBiographyEN != null)
                        Text(
                          artist.strBiographyEN!,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 24),
                      Text('Albums (${albums.length})',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...albums.take(3).map(
                            (album) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: album.strAlbumThumb != null
                                ? CachedNetworkImage(
                              imageUrl: album.strAlbumThumb!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                                : const Icon(Icons.album),
                            title: Text(
                              album.strAlbum,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(album.intYearReleased ?? ''),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigation vers AlbumDetails
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Titres les plus appréciés',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(thickness: 1),
                      FutureBuilder<List<Track>>(
                        future: context.read<MusicRepository>().getTracksByAlbumId(albums.first.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text("Aucun titre trouvé");
                          }

                          final tracks = snapshot.data!;
                          return Column(
                            children: List.generate(tracks.take(7).length, (i) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Text(
                                      '${i + 1}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    title: Text(tracks[i].title),
                                  ),
                                  const Divider(height: 1),
                                ],
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
