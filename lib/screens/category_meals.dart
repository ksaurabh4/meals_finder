import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../data/dummy_data.dart';

class CategoryMeals extends StatefulWidget {
  static const pageRoute = '/category-meals';
  final List<Meal> availableMeals;

  // final String categoryName;
  const CategoryMeals(this.availableMeals, {super.key});

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String categoryTitle = '';
  List<Meal> displayableMeals = [];
  var _isLoadedInitData = false;
  @override
  void didChangeDependencies() {
    if (!_isLoadedInitData) {
      final routesArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routesArgs['title'] as String;
      final categoryId = routesArgs['id'] as String;
      displayableMeals = widget.availableMeals
          .where((ele) => ele.categories.contains(categoryId))
          .toList();
      _isLoadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayableMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: displayableMeals[index].id,
          title: displayableMeals[index].title,
          imageUrl: displayableMeals[index].imageUrl,
          duration: displayableMeals[index].duration,
          complexity: displayableMeals[index].complexity,
          affordability: displayableMeals[index].affordability,
        ),
        itemCount: displayableMeals.length,
      ),
    );
  }
}
