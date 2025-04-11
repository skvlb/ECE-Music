import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/charts/charts_bloc.dart';
import '../blocs/charts/charts_event.dart';
import '../blocs/charts/charts_state.dart';
import '../models/album.dart';
import '../models/track.dart';

class ChartsTab extends StatefulWidget {
  const ChartsTab({super.key});

  @override
  State<ChartsTab> createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> {
  bool showTracks = true;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ChartsBloc>();
    bloc.add(LoadTopAlbums());
    bloc.add(LoadTopTracks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartsBloc, ChartsState>(
      builder: (context, state) {
        if (state.status == ChartsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final albums = state.topAlbums.take(8).toList();
        final tracks = state.topTracks.take(8).toList();

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  'Classements',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFPro',
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showTracks = true),
                      child: Column(
                        children: [
                          Text(
                            'Titres',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SFPro',
                              fontSize: 16,
                              color: showTracks ? Colors.black : Colors.black45,
                            ),
                          ),
                          if (showTracks)
                            Container(
                              height: 2,
                              margin: const EdgeInsets.only(top: 4),
                              color: Colors.green,
                            )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showTracks = false),
                      child: Column(
                        children: [
                          Text(
                            'Albums',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SFPro',
                              fontSize: 16,
                              color: showTracks ? Colors.black45 : Colors.black,
                            ),
                          ),
                          if (!showTracks)
                            Container(
                              height: 2,
                              margin: const EdgeInsets.only(top: 4),
                              color: Colors.green,
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: showTracks ? tracks.length : albums.length,
                  itemBuilder: (context, index) {
                    if (showTracks) {
                      final track = tracks[index];
                      return ListTile(
                        leading: track.thumbUrl != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            track.thumbUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Text('${index + 1}'),
                        title: Text(
                          track.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(track.artistName ?? ''),
                        onTap: () {
                          context.go('/artist/${track.artistId}');
                        },
                      );
                    } else {
                      final album = albums[index];
                      return ListTile(
                        leading: Image.network(
                          album.strAlbumThumb ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          album.strAlbum,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(album.strArtist),
                        onTap: () {
                          context.go('/album/${album.id}');
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
