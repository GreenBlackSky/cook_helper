
class Pantry {
  var data = {
    "Rice": [true, false],
    "Buckwheat": [true, false],
    "Quinoa": [true, false],
    "Pasta": [true, false],
    "Potatoes": [false, false],
    "Oats": [true, false],
    "Eggs": [false, false],
    "Cottage cheese": [false, false],
    "Feta": [false, false],
    "Canned lentils": [true, false],
    "Lentils": [true, false],
    "Canned chickpeas": [true, false],
    "Canned black beans": [true, false],
    "Milk": [false, false],
    "Frozen mixed veg": [true, false],
    "Spinach": [false, false],
    "Broccoli": [false, false],
    "Zucchini": [false, false],
    "Peppers": [false, false],
    "Carrots": [false, false],
    "Onion": [false, false],
    "Garlic": [true, false],
    "Cucumbers": [false, false],
    "Tomatoes": [false, false],
    "Canned tomatoes": [true, false],
    "Tomato sauce": [true, false],
    "Curry paste": [true, false],
    "Salsa": [true, false],
    "Coconut milk": [false, false],
    "Banana": [false, false],
    "Bread": [false, false],
    "Peanut butter": [true, false],
    "Mushrooms": [false, false],
    "Sour cream": [false, false],
    "Canned corn": [true, false],
    "Avocado": [false, false],
    "Cheese": [false, false],
    "Olives": [true, false],
    "Cabbage": [false, false]
  };

  Set<String> getAllNames() {
    return data.keys.toSet();
  }

  bool betterStock(String name) {
    return data[name]![0];
  }

  bool haveAtHome(String name) {
    return data[name]![1];
  }

  void reverseHaveAtHome(String name) {
    data[name]![1] = !data[name]![1];
  }
}

var PANTRY = Pantry();
