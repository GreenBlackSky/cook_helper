import 'pantry.dart';
import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';
import "state_processor.dart";

class RecipiesView extends StatefulWidget {
  const RecipiesView({super.key});

  @override
  State<RecipiesView> createState() => _RecipiesViewState();
}

class _RecipiesViewState extends State<RecipiesView> {
  void addRecipeToCart(String recipe) {
    setState(() {
      PROCESSOR.addRecipeToCart(recipe);
    });
  }

  int haveIngredientsPercentage(String name) {
    var ingredients = COOK_BOOK.getIngredients(name);
    int total = ingredients.length;
    int haveAtHome = 0;
    for (String ing in ingredients) {
      if (PANTRY.inPantry(ing)) {
        haveAtHome++;
      }
    }
    return ((haveAtHome / total) * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    var recipes = COOK_BOOK.getAllNames().toList();
    recipes.sort(
      (a, b) {
        return (haveIngredientsPercentage(b) - haveIngredientsPercentage(a));
      },
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: recipes.map((entry) {
              return RecipeCard(entry, addRecipeToCart);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
