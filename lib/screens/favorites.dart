import 'package:flutter/material.dart';
import 'package:meals_finder/models/meal.dart';
import 'package:meals_finder/widgets/meal_item.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const Favorites(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: favoriteMeals[index].id,
          title: favoriteMeals[index].title,
          imageUrl: favoriteMeals[index].imageUrl,
          duration: favoriteMeals[index].duration,
          complexity: favoriteMeals[index].complexity,
          affordability: favoriteMeals[index].affordability,
        ),
        itemCount: favoriteMeals.length,
      );
    }
    return const Center(
        child: Text('You have no favorite meal yet. Start adding Some!'));
  }
}
