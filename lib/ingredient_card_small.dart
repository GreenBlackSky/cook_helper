import 'package:cook_helper/state_processor.dart';
import 'package:flutter/material.dart';

class IngredientCardSmall extends StatefulWidget {
  final String ingredient;

  const IngredientCardSmall(this.ingredient, {super.key});

  @override
  State<IngredientCardSmall> createState() => _IngredientCardSmallState();
}

class _IngredientCardSmallState extends State<IngredientCardSmall> {
  Widget getStatusIcon(String name) {
    var state = PROCESSOR.getState(name);
    if (state == IngredientState.inPantry) {
      return const Icon(Icons.done, color: Colors.green);
    } else if (state == IngredientState.inShoppingList) {
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
                    child: Text(widget.ingredient),
                  ),
                ),
                Expanded(child: getStatusIcon(widget.ingredient))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
