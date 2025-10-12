import 'package:flutter/material.dart';

import "cook_book.dart";
import 'recipe_card.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";

class RecipiesView extends StatefulWidget {
  const RecipiesView({super.key});

  @override
  State<RecipiesView> createState() => _RecipiesViewState();
}

class _RecipiesViewState extends State<RecipiesView> {
  final Future<CookBook> _cookBook = CookBook.getInstance();
  final Future<Pantry> _pantry = Pantry.getInstance();
  final Future<ShoppingList> _shoppingList = ShoppingList.getInstance();

  void addRecipeToCart(CookBook cookBook, Pantry pantry,
      ShoppingList shoppingList, String recipe) {
    setState(() {
      for (String ing in cookBook.getIngredients(recipe)) {
        if (!pantry.inPantry(ing) && !shoppingList.inList(ing)) {
          shoppingList.addToShoppingList(ing);
        }
      }
    });
  }

  int haveIngredientsPercentage(CookBook cookBook, Pantry pantry, String name) {
    var ingredients = cookBook.getIngredients(name);
    int total = ingredients.length;
    int haveAtHome = 0;
    for (String ing in ingredients) {
      if (pantry.inPantry(ing)) {
        haveAtHome++;
      }
    }
    return ((haveAtHome / total) * 100).toInt();
  }

  List<String> getRecipes(CookBook cookBook, Pantry pantry) {
    var recipes = cookBook.getAllNames().toList();
    recipes.sort(
      (a, b) {
        return (haveIngredientsPercentage(cookBook, pantry, b) -
            haveIngredientsPercentage(cookBook, pantry, a));
      },
    );
    return recipes;
  }

  Widget buildView(
      CookBook cookBook, Pantry pantry, ShoppingList shoppingList) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getRecipes(cookBook, pantry).map((entry) {
              return RecipeCard(
                pantry,
                shoppingList,
                entry,
                cookBook.getIngredients(entry),
                (String s) =>
                    addRecipeToCart(cookBook, pantry, shoppingList, s),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_cookBook, _pantry, _shoppingList]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildView(
            snapshot.data![0] as CookBook,
            snapshot.data![1] as Pantry,
            snapshot.data![2] as ShoppingList,
          );
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}
