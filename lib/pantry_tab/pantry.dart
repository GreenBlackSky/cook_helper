import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class Ingredient {
  int id;
  String name;
  bool betterStock;
  String category;

  Ingredient(this.id, this.name, this.betterStock, this.category);
}

class Pantry {
  final Map<int, Ingredient> _data = {};
  Set<int> _ownerwhip = {};
  bool _initialized = false;

  Pantry._();

  static final instance = Pantry._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final String itemsJsonString =
        await rootBundle.loadString('assets/pantry.json');
    Map<String, dynamic> allItems = jsonDecode(itemsJsonString);
    final String categoriesJsonString =
        await rootBundle.loadString('assets/categories.json');
    Map<String, dynamic> categories = jsonDecode(categoriesJsonString);

    for (String key in allItems.keys) {
      Map<String, dynamic> value = allItems[key];
      String name = value['name'];
      bool betterStock = value['betterStock'];
      String categoryKey = value['category'].toString();
      String category = categories[categoryKey];
      int id = int.tryParse(key)!;
      _data[id] = Ingredient(id, name, betterStock, category);
    }

    var prefs = await SharedPreferences.getInstance();
    List<String> stringData = (prefs.getStringList('pantry') ?? []);
    _ownerwhip = stringData.map((s) => int.tryParse(s)!).toSet();

    _initialized = true;
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> toSave = _ownerwhip.map((i) => i.toString()).toList();
    await pref.setStringList('pantry', toSave);
  }

  Set<int> getAllItems() {
    return _data.keys.toSet();
  }

  Ingredient getItem(int id) {
    return _data[id]!;
  }

  bool inPantry(int id) {
    return _ownerwhip.contains(id);
  }

  void addToPantry(int id) {
    _ownerwhip.add(id);
    saveToPrefs();
  }

  void removeFromPantry(int id) {
    _ownerwhip.remove(id);
    saveToPrefs();
  }
}
