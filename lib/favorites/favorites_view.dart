import 'package:flutter/material.dart';

import 'favorites.dart';
import "../cook_book_tab/cook_book.dart";
import '../cook_book_tab/recipe_card.dart';
import '../pantry_tab/pantry.dart';
import "../shopping_list_tab/shopping_list.dart";

// TODO common base class waitable
// TODO remove card when unchecked

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
 
  Widget buildView() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Favorites.instance.getFavorites().map((entry) => RecipeCard(entry)).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        CookBook.instance.init(),
        Favorites.instance.init(),
        Pantry.instance.init(),
        ShoppingList.instance.init(),
      ]),
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
