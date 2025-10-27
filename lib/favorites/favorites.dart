import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  Set<int> _data = {};
  bool _initialized = false;

  Favorites._();

  static final instance = Favorites._();

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> stringData = (prefs.getStringList('favorites') ?? []);
    _data = stringData.map((s) => int.tryParse(s)!).toSet();
    _initialized = true;
  }

  Future<void> saveToPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('favorites', _data.map((i) => i.toString()).toList());
  }

  bool inList(int id) {
    return _data.contains(id);
  }

  Set<int> getFavorites() {
    return _data.toSet();
  }

  void addToFavorites(int id) {
    _data.add(id);
    saveToPrefs();
  }

  void removeFromFavorites(int id) {
    _data.remove(id);
    saveToPrefs();
  }
}
