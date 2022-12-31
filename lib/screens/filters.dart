import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const pageRoute = '/filters';

  final Map<String, bool> filters;
  final Function saveFilter;

  const Filters(this.filters, this.saveFilter, {super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    setState(() {
      _glutenFree = widget.filters['gluten'] == true;
      _lactoseFree = widget.filters['lactose'] == true;
      _vegan = widget.filters['vegan'] == true;
      _vegetarian = widget.filters['vegetarian'] == true;
    });
    super.initState();
  }

  Widget _buildSwitchListTile(title, subtitle, value, onChange) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: (newValue) {
          onChange(newValue);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final Map<String, bool> selectedFilter = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilter(selectedFilter);
                }),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten Free', 'Include only gluten-free meal', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile('Lactose Free',
                  'Include only lactose-free meal', _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegan Only', 'Include only vegan meal', _vegan, (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile('Vegetarian Only',
                  'Include only vegetarian meal', _vegetarian, (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
