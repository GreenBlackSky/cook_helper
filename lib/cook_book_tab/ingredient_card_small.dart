import 'package:flutter/material.dart';
import "../pantry_tab/pantry.dart";
import "../shopping_list_tab/shopping_list.dart";

class IngredientCardSmall extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientCardSmall(this.ingredient, {super.key});

  @override
  State<IngredientCardSmall> createState() => _IngredientCardSmallState();
}

class _IngredientCardSmallState extends State<IngredientCardSmall> {
  Widget getStatusIcon() {
    if (Pantry.instance.inPantry(widget.ingredient.id)) {
      return const Icon(Icons.done, color: Colors.green);
    } else if (ShoppingList.instance.inList(widget.ingredient.id)) {
      return const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
      );
    } else {
      return const Icon(
        Icons.close,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 400,
          height: 40,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(widget.ingredient.name),
                  ),
                ),
                Expanded(child: getStatusIcon())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
