import 'package:cook_helper/pantry_tab/pantry.dart';
import 'package:flutter/material.dart';
import 'cart.dart';

class ShoppingListCard extends StatefulWidget {
  final Ingredient ingredient;

  final void Function(int) removeSelf;

  const ShoppingListCard(this.ingredient, this.removeSelf, {super.key});

  @override
  State<ShoppingListCard> createState() => _ShoppingListCardState();
}

class _ShoppingListCardState extends State<ShoppingListCard> {
  Widget getHaveAtHomeIcon() {
    if (Cart.instance.inCart(widget.ingredient.id)) {
      return const Icon(Icons.shopping_cart, color: Colors.green);
    } else {
      return const Icon(
        Icons.shopping_cart,
        color: Colors.red,
      );
    }
  }

  Widget getRemoveButton() {
    return IconButton(
      onPressed: () {
        widget.removeSelf(widget.ingredient.id);
      },
      icon: const Icon(Icons.close),
    );
  }

  void changeCartState() {
    setState(() {
      if (Cart.instance.inCart(widget.ingredient.id)) {
        Cart.instance.removeFromCart(widget.ingredient.id);
      } else {
        Cart.instance.addToCart(widget.ingredient.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: changeCartState,
          child: SizedBox(
            width: 500,
            height: 60,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.ingredient.name),
                    ),
                  ),
                  Expanded(
                    child: getHaveAtHomeIcon(),
                  ),
                  Expanded(
                    child: getRemoveButton(),
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
