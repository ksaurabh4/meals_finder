import 'package:flutter/material.dart';
import 'package:meals_finder/models/meal.dart';
import 'package:meals_finder/screens/favorites.dart';
import 'package:meals_finder/screens/categories.dart';
import 'package:meals_finder/widgets/main_drawer.dart';

class Tabs extends StatefulWidget {
  final List<Meal> favoriteMeal;
  const Tabs(this.favoriteMeal, {super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedTab = 0;
  List<Map<String, dynamic>> _pages = [];

  void _selectTab(tabIndex) {
    setState(() {
      _selectedTab = tabIndex;
    });
  }

  @override
  void initState() {
    setState(() {
      _pages = [
        {'label': 'Categories', 'page': const Categories()},
        {'label': 'My Favorites', 'page': Favorites(widget.favoriteMeal)},
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedTab]['label'])),
      drawer: const MainDrawer(),
      body: _pages[_selectedTab]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        onTap: _selectTab,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
