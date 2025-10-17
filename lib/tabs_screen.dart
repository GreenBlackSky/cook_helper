import 'package:flutter/material.dart';
import 'pantry_tab/pantry_view.dart';
import 'cook_book_tab/cook_book_view.dart';
import 'shopping_list_tab/shopping_list_view.dart';
import 'favorites/favorites_view.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.star)),
            Tab(icon: Icon(Icons.menu_book)),
            Tab(icon: Icon(Icons.shopping_cart)),
            Tab(icon: Icon(Icons.home)),
          ],
        ),
        body: TabBarView(
          children: [
            FavoritesView(),
            CookBookView(),
            ShoppingListView(),
            PantryView(),
          ],
        ),
      ),
    );
  }
}
