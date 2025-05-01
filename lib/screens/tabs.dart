import "package:flutter/material.dart";
import "package:meals/screens/categories.dart";
import "package:meals/screens/meals.dart";
import "package:meals/models/meal.dart";
import "package:meals/widgets/main_drawer.dart";

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return TabsScreenState();
  }
}

class TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMesaage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    bool isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
      _showInfoMesaage("Meal is no longer a favorite.");
    } else {
      _favoriteMeals.add(meal);
      _showInfoMesaage("Marked as a favorite.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    String activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your favorites";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
