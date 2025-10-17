import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";

// TODO tags, search
class RecipiesView extends StatefulWidget {
  const RecipiesView({super.key});

  @override
  State<RecipiesView> createState() => _RecipiesViewState();
}

class _RecipiesViewState extends State<RecipiesView> {
  int haveIngredientsPercentage(String name) {
    var ingredients = CookBook.instance.getIngredients(name);
    int total = ingredients.length;
    int haveAtHome = 0;
    for (String ing in ingredients) {
      if (Pantry.instance.inPantry(ing)) {
        haveAtHome++;
      }
    }
    return ((haveAtHome / total) * 100).toInt();
  }

  List<String> getRecipes() {
    var recipes = CookBook.instance.getAllNames().toList();
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
