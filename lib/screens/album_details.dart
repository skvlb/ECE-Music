import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/album/album_bloc.dart';
import '../blocs/album/album_state.dart';
import '../widgets/track_tile.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_indicator.dart';
import '../blocs/album/album_event.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final String albumId;
  
  const AlbumDetailsScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        final album = state.album;
        
        return Scaffold(
          body: state.status == AlbumStatus.loading
              ? const LoadingIndicator()
              : state.status == AlbumStatus.failure
                  ? ErrorView(
                      message: state.errorMessage ?? 'Une erreur est survenue',
                      onRetry: () {
                        context.read<AlbumBloc>().add(LoadAlbumDetails(albumId));
                      },
                    )
                  : album == null
                      ? const Center(child: Text('Album non trouvé'))
                      : CustomScrollView(
                          slivers: [
                            // Entête avec image et informations basiques
                            SliverAppBar(
                              expandedHeight: 300,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Container(
                                  color: Colors.black,
                                  child: Stack(
                                    children: [
                                      // Image de fond
                                      Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: album.thumbUrl != null
                                              ? CachedNetworkImage(
                                                  imageUrl: album.thumbUrl!,
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
                                                ),
                                        ),
                                      ),
                                      // Informations de l'album
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.8),
                                                Colors.black,
                                              ],
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              // Pochette d'album
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: album.thumbUrl != null
                                                    ? CachedNetworkImage(
                                                        imageUrl: album.thumbUrl!,
                                                        width: 120,
                                                        height: 120,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => Container(
                                                          color: Colors.grey[850],
                                                          width: 120,
                                                          height: 120,
                                                        ),
                                                        errorWidget: (context, url, error) => Container(
                                                          color: Colors.grey[850],
                                                          width: 120,
                                                          height: 120,
                                                          child: const Icon(Icons.album),
                                                        ),
                                                      )
                                                    : Container(
                                                        color: Colors.grey[850],
                                                        width: 120,
                                                        height: 120,
                                                        child: const Icon(Icons.album, size: 50),
                                                      ),
                                              ),
                                              const SizedBox(width: 16),
                                              // Informations textuelles
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      album.title,
                                                      style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context.push('/artist/${album.artistId}');
                                                      },
                                                      child: Text(
                                                        album.artistName,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    if (album.yearReleased != null) ...[
                                                      Text(
                                                        album.yearReleased!,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey[400],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                    ],
                                                    if (album.genre != null) ...[
                                                      Text(
                                                        album.genre!,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey[400],
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            
                            // Note et votes
                            if (album.score != null && album.scoreVotes != null)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${album.scoreDouble?.toStringAsFixed(1) ?? "?"}/10',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${album.scoreVotes} votes',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                            // Description
                            if (album.descriptionEN != null && album.descriptionEN!.isNotEmpty)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        album.getDescription(Localizations.localeOf(context).languageCode),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                            // Titres
                            if (state.tracks.isNotEmpty)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Titres',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            
                            // Liste des titres
                            if (state.tracks.isNotEmpty)
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final track = state.tracks[index];
                                    return TrackTile(
                                      track: track,
                                      showArtist: false,
                                      showAlbum: false,
                                      onTap: () {
                                        // Navigation vers l'écran des paroles si disponible
                                      },
                                    );
                                  },
                                  childCount: state.tracks.length,
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