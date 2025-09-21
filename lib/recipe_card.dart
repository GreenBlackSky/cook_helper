import 'pantry.dart';
import 'package:flutter/material.dart';
import 'cook_book.dart';
import 'ingredient_card_small.dart';
import 'shopping_list.dart';

class RecipeCard extends StatefulWidget {
  final String recipe;
  const RecipeCard(this.recipe, {super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            setState(() {
              for (String ing in COOK_BOOK.getIngredients(widget.recipe)) {
                if (!PANTRY.haveAtHome(ing)) {
                  SHOPPING_LIST.addToShoppingList(ing);
                }
              }
            });
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
                    children:
                        COOK_BOOK.getIngredients(widget.recipe).map((entry) {
                      return IngredientCardSmall(entry);
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
