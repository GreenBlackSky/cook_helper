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
            SHOPPING_LIST.reverseStateInList(widget.ingredient);
          });
        },
        icon: icon);
  }

  Widget getHasAtHomeButton() {
    Icon icon;
    if (PANTRY.haveAtHome(widget.ingredient)) {
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
            PANTRY.reverseHaveAtHome(widget.ingredient);
          });
        },
        icon: icon);
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
                    padding: const EdgeInsets.all(20.0),
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
