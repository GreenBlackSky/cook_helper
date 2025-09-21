import 'pantry.dart';
import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';
import 'shopping_list.dart';

class RecipiesView extends StatefulWidget {
  const RecipiesView({super.key});

  @override
  State<RecipiesView> createState() => _RecipiesViewState();
}

class _RecipiesViewState extends State<RecipiesView> {
  bool anyIngredientInShoppingList(String recipe) {
    for (String ing in COOK_BOOK.getIngredients(recipe)) {
      if (SHOPPING_LIST.inList(ing)) {
        return true;
      }
    }
    return false;
  }

  void addRecipeToCart(String recipe) {
    setState(() {
      if (anyIngredientInShoppingList(recipe)) {
        // Remove all
        for (String ing in COOK_BOOK.getIngredients(recipe)) {
          if (SHOPPING_LIST.inList(ing)) {
            SHOPPING_LIST.reverseStateInList(ing);
          }
        }
      } else {
        // Add all
        for (String ing in COOK_BOOK.getIngredients(recipe)) {
          if (!PANTRY.haveAtHome(ing)) {
            SHOPPING_LIST.reverseStateInList(ing);
          }
        }
      }
    });
  }

  int haveIngredientsPercentage(String name) {
    var ingredients = COOK_BOOK.getIngredients(name);
    int total = ingredients.length;
    int haveAtHome = 0;
    for (String ing in ingredients) {
      if (PANTRY.haveAtHome(ing)) {
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
      appBar: AppBar(title: const Text('Recipes')),
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
