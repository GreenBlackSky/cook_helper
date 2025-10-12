import 'package:flutter/material.dart';
import '../shopping_list_tab/shopping_list.dart';
import 'ingredient_card.dart';
import 'pantry.dart';

// TODO Add sorting button

class IngredientsView extends StatefulWidget {

  const IngredientsView({super.key});

  @override
  State<IngredientsView> createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  final Future<Pantry> _pantry = Pantry.getInstance();
  final Future<ShoppingList> _shoppingList = ShoppingList.getInstance();

  Widget buildView(Pantry pantry, ShoppingList shoppingList) {
    var names = pantry.getAllNames().toList();
    names.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: names.map((entry) {
              return IngredientCard(pantry, shoppingList, entry);
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
          );
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}
