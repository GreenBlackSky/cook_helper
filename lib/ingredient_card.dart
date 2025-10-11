import 'package:flutter/material.dart';
import 'pantry.dart';
import 'shopping_list.dart';

class IngredientCard extends StatefulWidget {
  final String ingredient;

  const IngredientCard(this.ingredient, {super.key});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  Widget getBetterStockIcon() {
    if (PANTRY.betterStock(widget.ingredient)) {
      return const Icon(Icons.home);
    } else {
      return const Icon(Icons.store);
    }
  }

  Widget getShoppingCartButton() {
    Icon icon;
    if (SHOPPING_LIST.inList(widget.ingredient)) {
      icon = const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
      );
    } else {
      icon = const Icon(Icons.shopping_cart);
    }
    return IconButton(
        onPressed: () {
          setState(() {
            if (SHOPPING_LIST.inList(widget.ingredient)) {
              SHOPPING_LIST.removeFromShoppingList(widget.ingredient);
            } else {
              SHOPPING_LIST.addToShoppingList(widget.ingredient);
            }
          });
        },
        icon: icon);
  }

  Widget getHasAtHomeButton() {
    Icon icon;
    if (PANTRY.inPantry(widget.ingredient)) {
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
          if (PANTRY.inPantry(widget.ingredient)) {
            PANTRY.removeFromPantry(widget.ingredient);
          } else {
            PANTRY.addToPantry(widget.ingredient);
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
                    child: Text(widget.ingredient),
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
