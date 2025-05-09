import "package:flutter/material.dart";

import "package:meals/data/dummy_data.dart";
import "package:meals/models/category.dart";
import "package:meals/models/meal.dart";
import "package:meals/screens/meals.dart";
import "package:meals/widgets/category_grid_item.dart";

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onToggleFavorite;

  const CategoriesScreen({super.key, required this.onToggleFavorite});

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> filteredMeals =
        dummyMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        for (final Category category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => {_selectCategory(context, category)},
          ),
      ],
    );
  }
}
