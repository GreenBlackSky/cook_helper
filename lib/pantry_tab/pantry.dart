import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class Pantry {
  final Map<String, bool> _data = {};
  final Map<String, bool> _conditions = {};
  bool _initialized = false;

  Pantry._();

  static final instance = Pantry._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final String jsonString = await rootBundle.loadString('assets/pantry.json');
    Map<String, bool> allItems =
        (jsonDecode(jsonString) as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as bool));

    var prefs = await SharedPreferences.getInstance();
    var storedData = (prefs.getStringList('pantry') ?? []).toSet();

    for (String key in allItems.keys) {
      _data[key] = storedData.contains(key);
      _conditions[key] = allItems[key]!;
    }
    _initialized = true;
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> toSave = [];
    for (var key in _data.keys) {
      if (_data[key]!) {
        toSave.add(key);
      }
    }
    await pref.setStringList('pantry', toSave);
  }

  Set<String> getAllNames() {
    return _data.keys.toSet();
  }

  bool betterStock(String name) {
    return _conditions.containsKey(name) && _conditions[name]!;
  }

  bool inPantry(String name) {
    return _data.containsKey(name) && _data[name]!;
  }

  void addToPantry(String name) {
    _data[name] = true;
    saveToPrefs();
  }

  void removeFromPantry(String name) {
    _data[name] = false;
    saveToPrefs();
  }
}
