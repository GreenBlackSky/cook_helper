import 'package:flutter/material.dart';
import 'pantry_tab/pantry_view.dart';
import 'cook_book_tab/cook_book_view.dart';
import 'shopping_list_tab/shopping_list_view.dart';
import 'favorites/favorites_view.dart';

class TabsScreen extends StatelessWidget {
  final favoritesView = const FavoritesView();
  final cookBookView = const CookBookView();
  final shoppingListView = const ShoppingListView();
  final pantryView = const PantryView();

  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.star)),
            Tab(icon: Icon(Icons.menu_book)),
            Tab(icon: Icon(Icons.shopping_cart)),
            Tab(icon: Icon(Icons.home)),
          ],
        ),
        body: TabBarView(
          children: [
            favoritesView,
            cookBookView,
            shoppingListView,
            pantryView,
          ],
        ),
      ),
    );
  }
}
