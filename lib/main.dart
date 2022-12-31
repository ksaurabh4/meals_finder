import 'package:flutter/material.dart';
import 'package:meals_finder/data/dummy_data.dart';
import 'package:meals_finder/models/meal.dart';
import 'package:meals_finder/screens/tabs.dart';
import '../screens/meal_details.dart';
import '../screens/category_meals.dart';
import '../screens/filters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avalableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  bool _isFavorite(mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _toggleFavoriteMeal(mealId) {
    int index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (index > -1) {
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  void _saveFilter(availableFilter) {
    setState(() {
      _filter = availableFilter;
      _avalableMeals = DUMMY_MEALS.where((meals) {
        if (availableFilter['gluten'] == true && !meals.isGlutenFree) {
          return false;
        }
        if (availableFilter['lactose'] == true && !meals.isLactoseFree) {
          return false;
        }
        if (availableFilter['vegan'] == true && !meals.isVegan) {
          return false;
        }
        if (availableFilter['vegetarian'] == true && !meals.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals Finder',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          colorScheme: const ColorScheme.light(
              primary: Colors.pink, secondary: Colors.amber),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodySmall: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleMedium: const TextStyle(
                  fontFamily: 'RobotoCondense',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 51, 51, 1)))),
      // home: const Categories(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => Tabs(_favoriteMeals),
        CategoryMeals.pageRoute: (ctx) => CategoryMeals(_avalableMeals),
        MealDetails.pageRoute: (ctx) =>
            MealDetails(_toggleFavoriteMeal, _isFavorite),
        Filters.pageRoute: (ctx) => Filters(_filter, _saveFilter),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryMeals(_avalableMeals));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Finder'),
      ),
      body: const Center(
        child: Text('this is new app'),
      ),
    );
  }
}
