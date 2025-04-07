import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../widgets/artist_tile.dart';
import '../widgets/album_tile.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  
  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(SearchArtistsAndAlbums(query));
    } else {
      context.read<SearchBloc>().add(ClearSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rechercher',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Artiste, album...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchBloc>().add(ClearSearch());
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.status == SearchStatus.initial) {
                  return const Center(
                    child: Text('Recherchez un artiste ou un album'),
                  );
                } else if (state.status == SearchStatus.loading) {
                  return const LoadingIndicator();
                } else if (state.status == SearchStatus.failure) {
                  return ErrorView(
                    message: state.errorMessage ?? 'Une erreur est survenue',
                    onRetry: () {
                      context.read<SearchBloc>().add(SearchArtistsAndAlbums(state.query));
                    },
                  );
                }
                
                if (state.artists.isEmpty && state.albums.isEmpty) {
                  return const Center(
                    child: Text('Aucun résultat trouvé'),
                  );
                }
                
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.artists.isNotEmpty) ...[
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.artists.length,
                          itemBuilder: (context, index) {
                            final artist = state.artists[index];
                            return ArtistTile(
                              artist: artist,
                              onTap: () {
                                context.push('/artist/${artist.id}');
                              },
                            );
                          },
                        ),
                      ],
                      if (state.albums.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Albums',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.albums.length,
                          itemBuilder: (context, index) {
                            final album = state.albums[index];
                            return AlbumTile(
                              album: album,
                              onTap: () {
                                context.push('/album/${album.id}');
                              },
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}