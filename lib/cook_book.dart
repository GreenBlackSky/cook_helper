import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


class CookBook {
  final Map<String, List<String>> _data = {};

  CookBook() {
    loadFromData();
  }

  Future<void> loadFromData() async {
    final String jsonString = await rootBundle.loadString('cook_book.json');
    Map<String, dynamic> recipes = jsonDecode(jsonString) as Map<String, dynamic>;
    for(String key in recipes.keys) {
      _data[key] = [];
      for(String ing in recipes[key]) {
        _data[key]!.add(ing);
      }
    }
  }

  Set<String> getAllNames() {
    return _data.keys.toSet();
  }

  List<String> getIngredients(String name) {
    if(!_data.containsKey(name)){
      return [];
    }
    return _data[name]!;
  }
}

var COOK_BOOK = CookBook();
