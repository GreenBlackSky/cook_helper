import 'package:flutter/material.dart';
import 'cart.dart';

class ShoppingListCard extends StatefulWidget {
  final String ingredient;
  final void Function(String) removeSelf;

  const ShoppingListCard(this.ingredient, this.removeSelf, {super.key});

  @override
  State<ShoppingListCard> createState() => _ShoppingListCardState();
}

class _ShoppingListCardState extends State<ShoppingListCard> {
  Widget getHaveAtHomeIcon() {
    if (CART.inCart(widget.ingredient)) {
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
        widget.removeSelf(widget.ingredient);
      },
      icon: const Icon(Icons.close),
    );
  }

  void changeCartState() {
    setState(() {
      if (CART.inCart(widget.ingredient)) {
        CART.removeFromCart(widget.ingredient);
      } else {
        CART.addToCart(widget.ingredient);
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
                      child: Text(widget.ingredient),
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
