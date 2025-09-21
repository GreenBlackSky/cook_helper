import 'package:flutter/material.dart';
import 'ingredient_card.dart';
import 'pantry.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingredients')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: PANTRY.getAllNames().map((entry) {
              return IngredientCard(entry);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
