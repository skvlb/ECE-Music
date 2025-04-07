import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import '../models/favorites.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoris',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status == FavoritesStatus.initial || state.status == FavoritesStatus.loading) {
            return const LoadingIndicator();
          } else if (state.status == FavoritesStatus.failure) {
            return ErrorView(
              message: state.errorMessage ?? 'Une erreur est survenue',
              onRetry: () {
                context.read<FavoritesBloc>().add(LoadFavorites());
              },
            );
          }
          
          if (state.favorites.isEmpty) {
            return const Center(
              child: Text(
                'Aucun artiste favori',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Artistes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = state.favorites[index];
                    return _FavoriteArtistTile(
                      favorite: favorite,
                      onTap: () {
                        context.push('/artist/${favorite.id}');
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FavoriteArtistTile extends StatelessWidget {
  final FavoriteArtist favorite;
  final VoidCallback onTap;
  
  const _FavoriteArtistTile({
    required this.favorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: favorite.thumbUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(favorite.thumbUrl!),
              radius: 25,
            )
          : const CircleAvatar(
              child: Icon(Icons.person),
              radius: 25,
            ),
      title: Text(favorite.name),
      subtitle: favorite.genre != null
          ? Text(favorite.genre!)
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}