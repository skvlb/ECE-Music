import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/charts/charts_bloc.dart';
import '../blocs/charts/charts_event.dart';
import '../blocs/charts/charts_state.dart';
import '../widgets/album_tile.dart';
import '../widgets/track_tile.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_indicator.dart';

class ChartsTab extends StatelessWidget {
  const ChartsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text(
                'Classements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              floating: true,
              pinned: true,
              bottom: TabBar(
                tabs: const [
                  Tab(text: 'Titres'),
                  Tab(text: 'Albums'),
                ],
                indicatorColor: Colors.green,
              ),
            ),
          ];
        },
        body: BlocBuilder<ChartsBloc, ChartsState>(
          builder: (context, state) {
            if (state.status == ChartsStatus.initial || state.status == ChartsStatus.loading) {
              return const LoadingIndicator();
            } else if (state.status == ChartsStatus.failure) {
              return ErrorView(
                message: state.errorMessage ?? 'Une erreur est survenue',
                onRetry: () {
                  context.read<ChartsBloc>().add(RefreshCharts());
                },
              );
            }
            
            return TabBarView(
              children: [
                // Singles Tab
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<ChartsBloc>().add(RefreshCharts());
                  },
                  child: ListView.builder(
                    itemCount: state.singles.length,
                    itemBuilder: (context, index) {
                      final track = state.singles[index];
                      return TrackTile(
                        track: track,
                        rank: index + 1,
                        onTap: () {
                          context.push('/artist/${track.artistId}');
                        },
                      );
                    },
                  ),
                ),
                // Albums Tab
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<ChartsBloc>().add(RefreshCharts());
                  },
                  child: ListView.builder(
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}