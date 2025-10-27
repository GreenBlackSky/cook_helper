import 'package:flutter/material.dart';
import 'shopping_list.dart';
import 'shopping_list_card.dart';
import "../pantry_tab/pantry.dart";
import "cart.dart";

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  void dropList() {
    setState(() {
      ShoppingList.instance.dropList();
    });
  }

  void buyList() {
    setState(() {
      for (int item in Cart.instance.getItems()) {
        if (!Pantry.instance.inPantry(item)) {
          Pantry.instance.addToPantry(item);
        }
        Cart.instance.removeFromCart(item);
        ShoppingList.instance.removeFromShoppingList(item);
      }
    });
  }

  void removeCard(int id) {
    setState(() {
      ShoppingList.instance.removeFromShoppingList(id);
    });
  }

  Widget buildView() {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => buyList(),
                icon: const Icon(Icons.done, color: Colors.green),
              ),
              IconButton(
                onPressed: () => dropList(),
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
            children: ShoppingList.instance
                .getShoppingList()
                .map((id) => ShoppingListCard(
                      Pantry.instance.getItem(id),
                      removeCard,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Future.wait([Pantry.instance.init(), ShoppingList.instance.init()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildView();
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}
