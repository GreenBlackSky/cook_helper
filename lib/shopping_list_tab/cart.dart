class Cart {
  final Set<int> _data = {};

  Cart._();

  static final instance = Cart._();

  Set<int> getItems() {
    return _data.toSet();
  }

  bool inCart(int id) {
    return _data.contains(id);
  }

  void addToCart(int id) {
    _data.add(id);
  }

  void removeFromCart(int id) {
    _data.remove(id);
  }
}
