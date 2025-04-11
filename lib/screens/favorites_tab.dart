import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final box = Hive.box<String>('favorites');

          final artistFavorites = box.keys
              .where((key) => key.startsWith('artist_'))
              .map((key) => box.get(key))
              .whereType<String>()
              .toList();

          final albumFavorites = box.keys
              .where((key) => key.startsWith('album_'))
              .map((key) => box.get(key))
              .whereType<String>()
              .toList();

          Widget buildAvatar(String? url, IconData fallbackIcon) {
            return url != null && url.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: url,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Icon(fallbackIcon, size: 28),
              ),
            )
                : CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(fallbackIcon),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              const SizedBox(height: 12),
              const Text(
                'Favoris',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Mes artistes & albums',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'SFPro',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              /// ARTISTES
              const Text(
                'Artistes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              if (artistFavorites.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Aucun artiste en favori pour le moment.'),
                ),
              ...artistFavorites.map(
                    (data) {
                  final parts = data.split('|');
                  final name = parts[0];
                  final imageUrl = parts.length > 1 ? parts[1] : null;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: buildAvatar(imageUrl, Icons.person),
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Naviguer vers ArtistDetailsScreen
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// ALBUMS
              const Text(
                'Albums',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              if (albumFavorites.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Aucun album en favori pour le moment.'),
                ),
              ...albumFavorites.map(
                    (data) {
                  final parts = data.split('|');
                  final name = parts[0];
                  final imageUrl = parts.length > 1 ? parts[1] : null;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageUrl != null && imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                          const Icon(Icons.album),
                        )
                            : Container(
                          width: 48,
                          height: 48,
                          color: Colors.white,
                          child: const Icon(Icons.album),
                        ),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      subtitle: const Text(
                        'Artiste inconnu',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Naviguer vers AlbumDetailsScreen
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
