import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class MealDetails extends StatelessWidget {
  static const pageRoute = '/meal-details';
  final Function toggleFavoriteMeal;
  final Function isFavorite;
  const MealDetails(
    this.toggleFavoriteMeal,
    this.isFavorite, {
    super.key,
  });

  Widget buildSectionHeader(BuildContext ctx, String sectionHeaderText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        sectionHeaderText,
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
    );
  }

  Widget buildSectionBody(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final mealId = routeArgs['mealId'] as String;
    final meal = DUMMY_MEALS.firstWhere((ele) => ele.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(children: [
              buildSectionHeader(context, 'Ingredients'),
              buildSectionBody(ListView.builder(
                itemBuilder: ((ctx, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          meal.ingredients[index],
                        ),
                      ),
                    )),
                itemCount: meal.ingredients.length,
              )),
              buildSectionHeader(context, 'Steps'),
              buildSectionBody(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        meal.steps[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: meal.steps.length,
              )),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: () {
          // Navigator.of(context).pop(mealId);
          toggleFavoriteMeal(mealId);
        },
      ),
    );
  }
}
