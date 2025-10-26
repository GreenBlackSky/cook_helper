import 'package:flutter/material.dart';
import '../shopping_list_tab/shopping_list.dart';
import 'ingredient_card.dart';
import 'pantry.dart';

// TODO Add sorting button have/miss/all
// TODO add search
// TODO categories frozen/canned/etc
// TODO factories
// TODO common data holder class

class PantryView extends StatefulWidget {
  const PantryView({super.key});

  @override
  State<PantryView> createState() => _PantryViewState();
}

class _PantryViewState extends State<PantryView> {
  Widget buildView() {
    var names = Pantry.instance.getAllNames().toList();
    names.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: names.map((entry) {
              return IngredientCard(entry);
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
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
