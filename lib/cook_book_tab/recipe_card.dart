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

// TODO add cooking time
// TODO add buttons for portions (after adding measures)
// TODO add full macro
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
      if (Favorites.instance.inList(widget.recipe.id)) {
        Favorites.instance.removeFromFavorites(widget.recipe.id);
        widget.onRemoved?.call();
      } else {
        Favorites.instance.addToFavorites(widget.recipe.id);
      }
    });
  }

  Widget getHeader() {
    Color starColor = Favorites.instance.inList(widget.recipe.id)
        ? Colors.yellow
        : Colors.grey;
    int total = widget.recipe.ingredients.length;
    int haveAtHome = 0;
    int inShoppigList = 0;
    for (Ingredient ing in widget.recipe.ingredients) {
      if (Pantry.instance.inPantry(ing.id)) {
        haveAtHome++;
      }
      if (ShoppingList.instance.inList(ing.id)) {
        inShoppigList++;
      }
    }

    Color cartColor =
        (total != haveAtHome && total == haveAtHome + inShoppigList)
            ? Colors.blue
            : Colors.grey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: changeFavoriteStatus,
          icon: Icon(
            Icons.star,
            color: starColor,
          ),
        ),
        Expanded(
          child: Text(
            softWrap: true,
            overflow: TextOverflow.visible,
            widget.recipe.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        IconButton(
          onPressed: addRecipeToCart,
          icon: Icon(Icons.shopping_cart, color: cartColor),
        ),
      ],
    );
  }

  Widget getDescription() {
    int total = widget.recipe.ingredients.length;
    int haveAtHome = 0;
    for (Ingredient ing in widget.recipe.ingredients) {
      if (Pantry.instance.inPantry(ing.id)) {
        haveAtHome++;
      }
    }
    Color color = total == haveAtHome ? Colors.green : Colors.red;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(widget.recipe.portions.toString(),
                style: const TextStyle(fontSize: 24)),
            const Icon(Icons.restaurant)
          ],
        ),
        Text("$haveAtHome / $total",
            style: TextStyle(fontSize: 24, color: color)),
        Text("${widget.recipe.kkal} kkal")
      ],
    );
  }

  Widget getIngredients() {
    return Column(
      children: widget.recipe.ingredients
          .map((entry) => IngredientCardSmall(entry))
          .toList(),
    );
  }

  Widget getRecipeText() {
    List<Widget> ret = [];
    for (int i = 0; i < widget.recipe.recipe.length; i++) {
      String line = widget.recipe.recipe[i];
      ret.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${i + 1}. $line"),
          ),
        ),
      );
    }
    return Column(children: ret);
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
            subtitle: getDescription(),
            showTrailingIcon: false,
            children: [getIngredients(), getRecipeText()],
          ),
        ),
      ),
    );
  }
}
