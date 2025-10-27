import 'package:shared_preferences/shared_preferences.dart';

class ShoppingList {
  Set<int> _data = {};
  bool _initialized = false;

  ShoppingList._();

  static final instance = ShoppingList._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> stringData = (prefs.getStringList('shopping_list') ?? []);
    _data = stringData.map((s) => int.tryParse(s)!).toSet();
    _initialized = true;
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList(
        'shopping_list', _data.map((i) => i.toString()).toList());
  }

  Set<int> getShoppingList() {
    return _data.toSet();
  }

  bool inList(int id) {
    return _data.contains(id);
  }

  void addToShoppingList(int id) {
    _data.add(id);
    saveToPrefs();
  }

  void removeFromShoppingList(int id) {
    _data.remove(id);
    saveToPrefs();
  }

  void dropList() {
    _data.clear();
    saveToPrefs();
  }
}
