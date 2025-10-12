class Cart {
  final Set<String> _data = {};
  static final Cart _instance = Cart();

  static Cart getInstance() {
    return _instance;
  }

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
