import 'package:cook_helper/cook_book_tab/cook_book.dart';
import 'package:flutter/material.dart';
import 'ingredient_card_small.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";
import "../favorites/favorites.dart";

class RecipeCard extends StatefulWidget {
  final String recipe;
  const RecipeCard(this.recipe, {super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

// TODO add cooking time and macro
// TODO unfold into instructions
// TODO tips

class _RecipeCardState extends State<RecipeCard> {
  void addRecipeToCart() {
    setState(() {
      for (String ing in CookBook.instance.getIngredients(widget.recipe)) {
        if (!Pantry.instance.inPantry(ing) &&
            !ShoppingList.instance.inList(ing)) {
          ShoppingList.instance.addToShoppingList(ing);
        }
      }
    });
  }

  void changeFavoriteStatus() {
    setState(() {
      if(Favorites.instance.inList(widget.recipe)) {
        Favorites.instance.removeFromFavorites(widget.recipe);
      } else {
        Favorites.instance.addToFavorites(widget.recipe);
      }
    });
  }

  Widget getHeader() {
    Color starColor = Favorites.instance.inList(widget.recipe) ? Colors.yellow : Colors.grey;
    Color cartColor = ShoppingList.instance.inList(widget.recipe) ? Colors.blue : Colors.grey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: changeFavoriteStatus, icon: Icon(Icons.star, color: starColor,)),
        Text(
          widget.recipe,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        IconButton(onPressed: addRecipeToCart, icon: Icon(Icons.shopping_cart, color: cartColor)),
      ],
    );
  }

  Widget getIngredients() {
    return Column(
      children: CookBook.instance
          .getIngredients(widget.recipe)
          .map((entry) => IngredientCardSmall(entry))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          // onTap: () {
          //   unfold/fold;
          // },
          child: SizedBox(
            width: 500,
            child: Center(
              child: Column(
                children: [getHeader(), getIngredients()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
