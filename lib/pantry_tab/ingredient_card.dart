import 'package:flutter/material.dart';
import 'pantry.dart';
import '../shopping_list_tab/shopping_list.dart';

class IngredientCard extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientCard(this.ingredient, {super.key});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  Widget getBetterStockIcon() {
    if (widget.ingredient.betterStock) {
      return const Icon(Icons.home);
    } else {
      return const Icon(Icons.store);
    }
  }

  Widget getShoppingCartButton() {
    Icon icon;
    if (ShoppingList.instance.inList(widget.ingredient.id)) {
      icon = const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
      );
    } else {
      icon = const Icon(Icons.shopping_cart);
    }
    return IconButton(
      icon: icon,
      onPressed: () {
        setState(() {
          if (ShoppingList.instance.inList(widget.ingredient.id)) {
            ShoppingList.instance.removeFromShoppingList(widget.ingredient.id);
          } else {
            ShoppingList.instance.addToShoppingList(widget.ingredient.id);
          }
        });
      },
    );
  }

  Widget getHasAtHomeButton() {
    Icon icon;
    if (Pantry.instance.inPantry(widget.ingredient.id)) {
      icon = const Icon(Icons.done, color: Colors.green);
    } else {
      icon = const Icon(
        Icons.close,
        color: Colors.red,
      );
    }
    return IconButton(
      onPressed: () {
        setState(() {
          if (Pantry.instance.inPantry(widget.ingredient.id)) {
            Pantry.instance.removeFromPantry(widget.ingredient.id);
          } else {
            Pantry.instance.addToPantry(widget.ingredient.id);
          }
        });
      },
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: SizedBox(
              width: 500,
              height: 60,
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.ingredient.name),
                  )),
                  Expanded(child: getBetterStockIcon()),
                  Expanded(child: getHasAtHomeButton()),
                  Expanded(child: getShoppingCartButton())
                ],
              ))),
        ),
      ),
    );
  }
}
