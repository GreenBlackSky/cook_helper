import 'pantry.dart';
import 'package:flutter/material.dart';
import 'shopping_list.dart';
import 'shopping_list_card.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  void dropList() {
    setState(() {
      SHOPPING_LIST.dropList();
    });
  }

  void buyList() {
    setState(() {
      for (String item in SHOPPING_LIST.getShoppingList()) {
        if (SHOPPING_LIST.inCart(item) && !PANTRY.haveAtHome(item)) {
          PANTRY.reverseHaveAtHome(item);
          SHOPPING_LIST.reverseStateInList(item);
        }
      }
    });
  }

  void removeCard(String name) {
    setState(() {
      SHOPPING_LIST.reverseStateInList(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping list')),
      persistentFooterButtons: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: buyList,
                icon: const Icon(Icons.done, color: Colors.green),
              ),
              IconButton(
                onPressed: dropList,
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
        )
      ],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: SHOPPING_LIST.getShoppingList().map((entry) {
              return ShoppingListCard(entry, removeCard);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
