class CookBook {
  var data = {
    "Oatmeal": {"Oats", "Milk", "Peanut butter", "Banana"},
    "Omelette": {"Eggs", "Spinach", "Milk", "Feta"},
    "Lentil & veggie stew": {"Lentils", "Onion", "Carrots", "Spinach", "Canned tomatoes"},
    "Baked potato with cheese": {"Potatoes", "Cottage cheese"},
    "Chickpea curry": {"Canned chickpeas", "Coconut milk", "Curry paste", "Frozen mixed veg"},
    "Buckwheat with Scrambled eggs, mushrooms": {"Buckwheat", "Eggs", "Mushrooms"},
    "Salad": {"Tomatoes", "Cucumbers", "Peppers", "Sour cream"},
    "Quinoa": {"Quinoa", "Zucchini", "Peppers", "Carrots", "Onion", "Feta"},
    "Pasta with lentil Bolognese": {"Pasta", "Canned lentils", "Tomato sauce", "Onion", "Garlic"},
    "Veggie burrito bowl": {"Rice", "Canned black beans", "Canned corn", "Salsa", "Avocado", "Cheese"},
    "Greek salad": {"Tomatoes", "Cucumbers", "Onion", "Feta", "Eggs", "Olives"},
    "Stewed Cabbage ": {"Cabbage", "Carrots", "Peppers", "Cottage cheese"},
  };

  Set<String> getAllNames() {
    return data.keys.toSet();
  }

  Set<String> getIngredients(String name) {
    return data[name]!;
  }
}

var COOK_BOOK = CookBook();
