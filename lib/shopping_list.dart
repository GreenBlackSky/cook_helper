import 'pantry.dart';

class ShoppingList {
  Map<String, bool> data = {};

  Set<String> getShoppingList(){
    return data.keys.toSet();
  }

  void addToShoppingList(String name) {
    if (data.containsKey(name)) {
      return;
    }
    data[name] = false;
  }

  void dropList() {
    data = {};
  }

  void reverseStateInCart(String name) {
    if (!data.containsKey(name)) {
      return;
    }
    data[name] = !data[name]!;
  }

  bool inList(String name) {
    return data.containsKey(name);
  }

  bool inCart(String name) {
    return data[name]!;
  }

  void buy() {
    for (var entry in data.entries) {
      if (entry.value && !PANTRY.haveAtHome(entry.key)) {
        PANTRY.reverseHaveAtHome(entry.key);
      }
    }
  }
}

var SHOPPING_LIST = ShoppingList();
