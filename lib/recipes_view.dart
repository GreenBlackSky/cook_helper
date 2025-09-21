import 'pantry.dart';
import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';

class RecipiesView extends StatelessWidget {
  const RecipiesView({super.key});

  int haveIngredientsPercentage(String name) {
    var ingredients = COOK_BOOK.getIngredients(name);
    int total = ingredients.length;
    int haveAtHome = 0;
    for (String ing in ingredients) {
      if(PANTRY.haveAtHome(ing)){
        haveAtHome++;
      }
    }
    return ((haveAtHome/total)*100).toInt();
  }

  @override
  Widget build(BuildContext context) {

    var recipes = COOK_BOOK.getAllNames().toList();
    recipes.sort((a, b) {
      return (haveIngredientsPercentage(b) - haveIngredientsPercentage(a));
    },);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipes')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: recipes.map((entry) {
                return RecipeCard(entry);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
