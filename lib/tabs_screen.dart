import 'package:flutter/material.dart';
import 'ingredients_view.dart';
import 'recipes_view.dart';
import 'shopping_list_view.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.menu_book)),
                Tab(icon: Icon(Icons.home)),
                Tab(
                  icon: Icon(Icons.shopping_cart),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RecipiesView(),
              IngredientsView(),
              ShoppingListView(),
            ],
          ),
        ),
      ),
    );
  }
}
