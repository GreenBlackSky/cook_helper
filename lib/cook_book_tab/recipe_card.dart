import 'package:cook_helper/cook_book_tab/cook_book.dart';
import 'package:flutter/material.dart';
import 'ingredient_card_small.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";

class RecipeCard extends StatefulWidget {
  final String recipe;
  const RecipeCard(this.recipe, {super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

// TODO add cooking time and macro
class _RecipeCardState extends State<RecipeCard> {
  void addRecipeToCart(String recipe) {
    setState(() {
      for (String ing in CookBook.instance.getIngredients(recipe)) {
        if (!Pantry.instance.inPantry(ing) &&
            !ShoppingList.instance.inList(ing)) {
          ShoppingList.instance.addToShoppingList(ing);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            addRecipeToCart(widget.recipe);
          },
          child: SizedBox(
            width: 500,
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.recipe,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Column(
                    children: CookBook.instance
                        .getIngredients(widget.recipe)
                        .map((entry) => IngredientCardSmall(entry))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
