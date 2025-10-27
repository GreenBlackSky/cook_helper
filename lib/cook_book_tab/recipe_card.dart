import 'package:cook_helper/cook_book_tab/cook_book.dart';
import 'package:flutter/material.dart';
import 'ingredient_card_small.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";
import "../favorites/favorites.dart";

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onRemoved;
  const RecipeCard(this.recipe, {this.onRemoved, super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

// TODO add cooking time and macro
// TODO unfold into instructions
// TODO tips

class _RecipeCardState extends State<RecipeCard> {
  void addRecipeToCart() {
    setState(() {
      for (Ingredient ing in widget.recipe.ingredients) {
        if (!Pantry.instance.inPantry(ing.id) &&
            !ShoppingList.instance.inList(ing.id)) {
          ShoppingList.instance.addToShoppingList(ing.id);
        }
      }
    });
  }

  void changeFavoriteStatus() {
    setState(() {
      if(Favorites.instance.inList(widget.recipe.id)) {
        Favorites.instance.removeFromFavorites(widget.recipe.id);
        widget.onRemoved?.call();
      } else {
        Favorites.instance.addToFavorites(widget.recipe.id);
      }
    });
  }

  Widget getHeader() {
    Color starColor = Favorites.instance.inList(widget.recipe.id) ? Colors.yellow : Colors.grey;
    // Color cartColor = ShoppingList.instance.inList(widget.recipe) ? Colors.blue : Colors.grey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: changeFavoriteStatus, icon: Icon(Icons.star, color: starColor,)),
        Text(
          widget.recipe.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        IconButton(onPressed: addRecipeToCart, icon: Icon(Icons.shopping_cart)),
      ],
    );
  }

  Widget getIngredients() {
    return Column(
      children: widget.recipe.ingredients.map((entry) => IngredientCardSmall(entry))
          .toList(),
    );
  }

List<Widget> getRecipeText() {
  List<Widget> ret = [];
  for(int i = 0; i < widget.recipe.recipe.length; i++) {
    String line = widget.recipe.recipe[i];
    ret.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${i + 1}. $line"),
        ),
      )
    );
  }
  return ret;
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 500,
          child: ExpansionTile(
            title: getHeader(),
            subtitle: getIngredients(),
            showTrailingIcon: false,
            children: getRecipeText(),
          ),
        ),
      ),
    );
  }
}
