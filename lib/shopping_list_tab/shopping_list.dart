import 'package:shared_preferences/shared_preferences.dart';

class ShoppingList {
  Set<String> _data = {};
  bool _initialized = false;

  static final ShoppingList _instance = ShoppingList();

  static Future<ShoppingList> getInstance() async {
    if (!_instance._initialized) {
      await _instance.init();
    }
    return _instance;
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _data = (prefs.getStringList('shopping_list') ?? []).toSet();
    _initialized = true;
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
