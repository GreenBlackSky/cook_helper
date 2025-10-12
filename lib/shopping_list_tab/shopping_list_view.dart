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
  final Cart _cart = Cart.getInstance();
  final Future<Pantry> _pantry = Pantry.getInstance();
  final Future<ShoppingList> _shoppingList = ShoppingList.getInstance();

  void dropList(ShoppingList shoppingList) {
    setState(() {
      shoppingList.dropList();
    });
  }

  void buyList(Pantry pantry, ShoppingList shoppingList, Cart cart) {
    setState(() {
      for (String item in cart.getItems()) {
        if (!pantry.inPantry(item)) {
          pantry.addToPantry(item);
          cart.removeFromCart(item);
          shoppingList.removeFromShoppingList(item);
        }
      }
    });
  }

  void removeCard(ShoppingList shoppingList, String name) {
    setState(() {
      shoppingList.removeFromShoppingList(name);
    });
  }

  Widget buildView(Pantry pantry, ShoppingList shoppingList, Cart cart) {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => buyList(pantry, shoppingList, cart),
                icon: const Icon(Icons.done, color: Colors.green),
              ),
              IconButton(
                onPressed: () => dropList(shoppingList),
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
            children: shoppingList.getShoppingList().map((entry) {
              return ShoppingListCard(
                cart,
                entry,
                (String s) => removeCard(shoppingList, s),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_pantry, _shoppingList]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildView(
            snapshot.data![0] as Pantry,
            snapshot.data![1] as ShoppingList,
            _cart,
          );
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}
