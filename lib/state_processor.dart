import "pantry.dart";
import "shopping_list.dart";
import "cart.dart";
import "cook_book.dart";

enum IngredientState { missing, inShoppingList, inCart, inPantry }

class StateProcessor {
  void addRecipeToCart(String recipe) {
    for (String ing in COOK_BOOK.getIngredients(recipe)) {
      if (!PANTRY.inPantry(ing) && !SHOPPING_LIST.inList(ing)) {
        SHOPPING_LIST.addToShoppingList(ing);
      }
    }
  }

  void buyCart() {
    for (String item in CART.getItems()) {
      if (!PANTRY.inPantry(item)) {
        PANTRY.addToPantry(item);
        CART.removeFromCart(item);
        SHOPPING_LIST.removeFromShoppingList(item);
      }
    }
  }

  IngredientState getState(String name) {
    if (PANTRY.inPantry(name)) {
      return IngredientState.inPantry;
    }
    if (SHOPPING_LIST.inList(name)) {
      return IngredientState.inShoppingList;
    }
    if (CART.inCart(name)) {
      return IngredientState.inCart;
    }
    return IngredientState.missing;
  }
}

var PROCESSOR = StateProcessor();
