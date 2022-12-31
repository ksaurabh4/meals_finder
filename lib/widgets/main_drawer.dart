import 'package:flutter/material.dart';
import '../screens/filters.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  Widget buildDrawerHeaderItem() {
    return const Center(
        child: Text(
      'Menu',
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
    ));
  }

  buildMenuTileItem(
      BuildContext context, IconData icon, String name, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
          child: buildDrawerHeaderItem(),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            children: [
              buildMenuTileItem(context, Icons.restaurant, 'Meals', () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
              buildMenuTileItem(context, Icons.settings, 'Filters', () {
                Navigator.of(context).pushReplacementNamed(Filters.pageRoute);
              }),
            ],
          ),
        )
      ],
    ));
  }
}
