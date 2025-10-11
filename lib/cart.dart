class Cart {
  final Set<String> _data = {};

  Set<String> getItems() {
    return _data.toSet();
  }

  bool inCart(String name) {
    return _data.contains(name);
  }

  void addToCart(String name) {
    _data.add(name);
  }

  void removeFromCart(String name) {
    _data.remove(name);
  }
}

var CART = Cart();
