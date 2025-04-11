import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_icons.dart';

import 'charts_tab.dart';
import 'search_tab.dart';
import 'favorites_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ChartsTab(),
          SearchTab(),
          FavoritesTab(),
        ],
      ),
bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white,
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.green,
  unselectedItemColor: Colors.grey,
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: _selectedIndex == 0 
          ? AppIcons.classements(color: Colors.green)
          : AppIcons.classements(color: Colors.grey),
      label: 'Classements',
    ),
    BottomNavigationBarItem(
      icon: _selectedIndex == 1 
          ? AppIcons.recherche(color: Colors.green) 
          : AppIcons.recherche(color: Colors.grey),
      label: 'Recherche',
    ),
    BottomNavigationBarItem(
      icon: _selectedIndex == 2 
          ? AppIcons.favoris(color: Colors.green) 
          : AppIcons.favoris(color: Colors.grey),
      label: 'Favoris',
    ),
  ],
),
    );
  }
}
