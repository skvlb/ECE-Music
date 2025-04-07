import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/artist/artist_bloc.dart';
import '../blocs/artist/artist_state.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';
import '../widgets/album_tile.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_indicator.dart';
import '../repositories/favorites_repository.dart';
import '../blocs/artist/artist_event.dart';


class ArtistDetailsScreen extends StatelessWidget {
  final String artistId;
  
  const ArtistDetailsScreen({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      builder: (context, state) {
        final artist = state.artist;
        
        return Scaffold(
          body: state.status == ArtistStatus.loading
              ? const LoadingIndicator()
              : state.status == ArtistStatus.failure
                  ? ErrorView(
                      message: state.errorMessage ?? 'Une erreur est survenue',
                      onRetry: () {
                        context.read<ArtistBloc>().add(LoadArtistDetails(artistId));
                      },
                    )
                  : artist == null
                      ? const Center(child: Text('Artiste non trouvé'))
                      : CustomScrollView(
                          slivers: [
                            // Entête avec image et informations basiques
                            SliverAppBar(
                              expandedHeight: 250,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                background: artist.bannerUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: artist.bannerUrl!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          color: Colors.grey[850],
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          color: Colors.grey[850],
                                          child: const Icon(Icons.error),
                                        ),
                                      )
                                    : artist.thumbUrl != null
                                        ? CachedNetworkImage(
                                            imageUrl: artist.thumbUrl!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(
                                              color: Colors.grey[850],
                                            ),
                                            errorWidget: (context, url, error) => Container(
                                              color: Colors.grey[850],
                                              child: const Icon(Icons.error),
                                            ),
                                          )
                                        : Container(
                                            color: Colors.grey[850],
                                            child: const Icon(Icons.person, size: 50),
                                          ),
                              ),
                              actions: [
                                BlocBuilder<FavoritesBloc, FavoritesState>(
                                  builder: (context, favState) {
                                    final favRepository = context.read<FavoritesRepository>();
                                    final isFavorite = favRepository.isFavorite(artist.id);
                                    
                                    return IconButton(
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : null,
                                      ),
                                      onPressed: () {
                                        context.read<FavoritesBloc>().add(
                                          ToggleFavorite(artist),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            
                            // Informations de l'artiste
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      artist.name,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (artist.genre != null) ...[
                                      Text(
                                        artist.genre!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                    if (artist.country != null) ...[
                                      Text(
                                        artist.country!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                    if (artist.formationYear != null) ...[
                                      Text(
                                        'Depuis ${artist.formationYear}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                    const SizedBox(height: 16),
                                    
                                    // Biographie
                                    if (artist.biographyEN != null && artist.biographyEN!.isNotEmpty) ...[
                                      const Text(
                                        'Biographie',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        artist.getBiography(Localizations.localeOf(context).languageCode),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                    
                                    // Albums
                                    if (state.albums.isNotEmpty) ...[
                                      const Text(
                                        'Albums',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            
                            // Liste des albums
                            if (state.albums.isNotEmpty)
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final album = state.albums[index];
                                    return AlbumTile(
                                      album: album,
                                      onTap: () {
                                        context.push('/album/${album.id}');
                                      },
                                    );
                                  },
                                  childCount: state.albums.length,
                                ),
                              ),
                            
                            // Espacement en bas
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 32),
                            ),
                          ],
                        ),
        );
      },
    );
  }
}