import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch(String query) {
    context.read<SearchBloc>().add(SearchArtistsAndAlbums(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                'Rechercher',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                onSubmitted: _onSearch,
                decoration: InputDecoration(
                  hintText: '  Céline Dion',
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      context.read<SearchBloc>().add(SearchArtistsAndAlbums(''));
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.status == SearchStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == SearchStatus.failure) {
                    return const Center(child: Text('Erreur lors de la recherche'));
                  } else if (state.artists.isEmpty && state.albums.isEmpty) {
                    return const Center(child: Text('Aucun résultat'));
                  }

                  return ListView(
                    children: [
                      if (state.artists.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Artistes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ...state.artists.map((artist) => Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: ClipOval(
                                    child: artist.strArtistThumb != null
                                        ? CachedNetworkImage(
                                      imageUrl: artist.strArtistThumb!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(Icons.person),
                                  ),
                                  title: Text(
                                    artist.strArtist,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    context.go('/artist/${artist.id}');
                                  },
                                ),
                              )),
                            ],
                          ),
                        ),
                      if (state.albums.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Albums',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ...state.albums.map((album) => Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: album.strAlbumThumb != null
                                        ? CachedNetworkImage(
                                      imageUrl: album.strAlbumThumb!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(Icons.album),
                                  ),
                                  title: Text(
                                    album.strAlbum,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(album.strArtist),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    context.go('/album/${album.id}');
                                  },
                                ),
                              )),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
