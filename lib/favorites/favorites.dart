import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  Set<String> _data = {};
  bool _initialized = false;

  Favorites._();

  static final instance = Favorites._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    _data = (prefs.getStringList('favorites') ?? []).toSet();
    _initialized = true;
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('favorites', _data.toList());
  }

  bool inList(String name) {
    return _data.contains(name);
  }

  Set<String> getFavorites() {
    return _data.toSet();
  }

  void addToFavorites(String name) {
    _data.add(name);
    saveToPrefs();
  }

  void removeFromFavorites(String name) {
    _data.remove(name);
    saveToPrefs();
  }
}
