import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CookBook {
  final Map<String, List<String>> _data = {};
  bool _initialized = false;

  static final CookBook _instance = CookBook();

  static Future<CookBook> getInstance() async {
    if (!_instance._initialized) {
      await _instance.init();
    }
    return _instance;
  }

  Future<void> init() async {
    final String jsonString = await rootBundle.loadString('cook_book.json');
    Map<String, dynamic> recipes =
        jsonDecode(jsonString) as Map<String, dynamic>;
    for (String key in recipes.keys) {
      _data[key] = [];
      for (String ing in recipes[key]) {
        _data[key]!.add(ing);
      }
    }
    _initialized = true;
  }

  Set<String> getAllNames() {
    return _data.keys.toSet();
  }

  List<String> getIngredients(String name) {
    if (!_data.containsKey(name)) {
      return [];
    }
    return _data[name]!;
  }
}
