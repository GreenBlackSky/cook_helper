import 'package:flutter/material.dart';
import 'ingredient_card_small.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";

class RecipeCard extends StatefulWidget {
  final Pantry pantry;
  final ShoppingList shoppingList;
  final String recipe;
  final List<String> ingredients;
  final void Function(String) addRecipeToCart;
  const RecipeCard(
    this.pantry,
    this.shoppingList,
    this.recipe,
    this.ingredients,
    this.addRecipeToCart, {
    super.key,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

// TODO add cooking time and macro
class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            widget.addRecipeToCart(widget.recipe);
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
                    children: widget.ingredients.map((entry) {
                      return IngredientCardSmall(
                        widget.pantry,
                        widget.shoppingList,
                        entry,
                      );
                    }).toList(),
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
