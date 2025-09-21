import 'package:flutter/material.dart';
import 'shopping_list.dart';

class ShoppingListCard extends StatefulWidget {
  final String ingredient;

  const ShoppingListCard(this.ingredient, {super.key});

  @override
  State<ShoppingListCard> createState() => _ShoppingListCardState();
}

class _ShoppingListCardState extends State<ShoppingListCard> {
  Widget getHaveAtHomeIcon(String name) {
    if (SHOPPING_LIST.inCart(name)) {
      return const Icon(Icons.shopping_cart, color: Colors.green);
    } else {
      return const Icon(
        Icons.shopping_cart,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            setState(() {
              SHOPPING_LIST.reverseStateInCart(widget.ingredient);
            });
          },
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
                    child: getHaveAtHomeIcon(widget.ingredient),
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
