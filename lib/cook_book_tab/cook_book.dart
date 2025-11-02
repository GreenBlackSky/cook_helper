import 'package:cook_helper/pantry_tab/pantry.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// TODO factories
// TODO common data holder class
// TODO separate static data classes and user data classes
// TODO fromJson methods
// TODO measures

class Recipe {
  int id;
  String name;
  String cookingTime = "";
  int portions = 2;
  int kkal = 0;
  double carbs = 0;
  double fat = 0;
  double protein = 0;
  List<Ingredient> ingredients;
  List<String> tags = [];
  List<String> tips = [];
  List<String> recipe;

  Recipe(
    this.id,
    this.name,
    this.portions,
    this.kkal,
    this.ingredients,
    this.recipe,
  );
}

class CookBook {
  final Map<int, Recipe> _data = {};
  bool _initialized = false;

  CookBook._();

  static final instance = CookBook._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final String jsonString =
        await rootBundle.loadString('assets/cook_book.json');
    Map<String, dynamic> recipes = jsonDecode(jsonString);
    var pantry = Pantry.instance;
    await pantry.init();

    for (String key in recipes.keys) {
      Map<String, dynamic> value = recipes[key];
      String name = value['name'];
      int portions = value['portions'];
      int kkal = value['kkal'];
      List<int> ingredientIds = List.from(value['ingredients']);
      List<Ingredient> ingredients =
          ingredientIds.map((s) => pantry.getItem(s)).toList();
      List<String> recipe = List.from(value['recipe']);
      int id = int.parse(key);
      _data[id] = Recipe(id, name, portions, kkal, ingredients, recipe);
    }
    _initialized = true;
  }

  Set<Recipe> getAll() {
    return _data.values.toSet();
  }

  Recipe getItem(int id) {
    return _data[id]!;
  }
}
