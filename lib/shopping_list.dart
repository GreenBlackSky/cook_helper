import 'package:shared_preferences/shared_preferences.dart';

import 'pantry.dart';
// TODO Persistent storage
class ShoppingList {
  Map<String, bool> data = {};

  ShoppingList() {
    loadFromPrefs();
  }

  Future<Map<String, bool>> getDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getStringList('shopping_list_keys') ?? [];
    Map<String, bool> ret = {};
    for (var key in keys) {
      data[key] = prefs.getBool('shopping_list_value_$key') ?? false;
    }
    return ret;
  }

  Future<void> loadFromPrefs() async {
    data = await getDataFromStorage();
  }

  Future<void> saveToPrefs() async {
    var storedData = await getDataFromStorage();

    var toRemove =
        storedData.keys.where((key) => !data.containsKey(key)).toList();
    var toAdd = data.keys.where((key) => !storedData.containsKey(key)).toList();
    var toUpdate = data.keys
        .where((key) =>
            storedData.containsKey(key) && data[key] != storedData[key])
        .toList();

    final prefs = await SharedPreferences.getInstance();

    for (var key in toRemove) {
      await prefs.remove('shopping_list_value_$key');
    }
    for (var key in toAdd) {
      await prefs.setBool('shopping_list_value_$key', data[key]!);
    }
    for (var key in toUpdate) {
      await prefs.setBool('shopping_list_value_$key', data[key]!);
    }
  }

  Set<String> getShoppingList() {
    return data.keys.toSet();
  }

  void reverseStateInList(String name) {
    if (data.containsKey(name)) {
      data.remove(name);
    } else {
      data[name] = false;
    }
    saveToPrefs();
  }

  void dropList() {
    data = {};
    saveToPrefs();
  }

  void reverseStateInCart(String name) {
    if (!data.containsKey(name)) {
      return;
    }
    data[name] = !data[name]!;
    saveToPrefs();
  }

  bool inList(String name) {
    return data.containsKey(name);
  }

  bool inCart(String name) {
    if (!data.containsKey(name)) {
      return false;
    }
    return data[name]!;
  }

  void buy() {
    for (var entry in data.entries) {
      if (entry.value && !PANTRY.haveAtHome(entry.key)) {
        PANTRY.reverseHaveAtHome(entry.key);
      }
    }
    saveToPrefs();
  }
}

var SHOPPING_LIST = ShoppingList();
