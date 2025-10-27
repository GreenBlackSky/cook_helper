import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";
import "../favorites/favorites.dart";

// TODO tags
// TODO search
// TODO random one
// TODO filter by have/dont have/all

class CookBookView extends StatefulWidget {
  const CookBookView({super.key});

  @override
  State<CookBookView> createState() => _CookBookViewState();
}

class _CookBookViewState extends State<CookBookView> {
  int haveIngredientsPercentage(Recipe recipe) {
    int total = recipe.ingredients.length;
    int haveAtHome = 0;
    for (Ingredient ing in recipe.ingredients) {
      if (Pantry.instance.inPantry(ing.id)) {
        haveAtHome++;
      }
    }
    return ((haveAtHome / total) * 100).toInt();
  }

  List<Recipe> getRecipes() {
    var recipes = CookBook.instance.getAll().toList();
    recipes.sort(
      (a, b) {
        return (haveIngredientsPercentage(b) - haveIngredientsPercentage(a));
      },
    );
    return recipes;
  }

  Widget buildView() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getRecipes().map((entry) => RecipeCard(entry)).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        CookBook.instance.init(),
        Favorites.instance.init(),
        Pantry.instance.init(),
        ShoppingList.instance.init(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildView();
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}