import 'package:shared_preferences/shared_preferences.dart';

class ShoppingList {
  Set<String> _data = {};

  ShoppingList() {
    loadFromPrefs();
  }

  Future<Set<String>> getDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getStringList('shopping_list') ?? [];
    return keys.toSet();
  }

  Future<void> loadFromPrefs() async {
    _data = await getDataFromStorage();
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('shopping_list', _data.toList());
  }

  Set<String> getShoppingList() {
    return _data.toSet();
  }

  bool inList(String name) {
    return _data.contains(name);
  }

  void addToShoppingList(String name) {
    _data.add(name);
    saveToPrefs();
  }

  void removeFromShoppingList(String name) {
    _data.remove(name);
    saveToPrefs();
  }

  void dropList() {
    _data.clear();
    saveToPrefs();
  }
}

var SHOPPING_LIST = ShoppingList();
