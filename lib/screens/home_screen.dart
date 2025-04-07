import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'charts_tab.dart';
import 'search_tab.dart';
import 'favorites_tab.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}

class HomeContent extends StatefulWidget {
  final int initialTabIndex;
  
  const HomeContent({super.key, required this.initialTabIndex});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3, 
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _tabController.addListener(_handleTabChange);
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
  
  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/search');
          break;
        case 2:
          context.go('/favorites');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChartsTab(),
          SearchTab(),
          FavoritesTab(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.green, width: 4),
            insets: EdgeInsets.only(bottom: 44),
          ),
          tabs: const [
            Tab(
              icon: Icon(Icons.bar_chart_rounded),
              text: 'Classements',
            ),
            Tab(
              icon: Icon(Icons.search),
              text: 'Recherche',
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: 'Favoris',
            ),
          ],
        ),
      ),
    );
  }
}