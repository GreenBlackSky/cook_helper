import 'package:flutter/material.dart';
import 'ingredient_card.dart';
import 'pantry.dart';

// TODO Add sorting button
class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    var names = PANTRY.getAllNames().toList();
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
}
