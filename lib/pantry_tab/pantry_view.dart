import 'package:flutter/material.dart';
import '../shopping_list_tab/shopping_list.dart';
import 'ingredient_card.dart';
import 'pantry.dart';

// TODO add search
// TODO categories frozen/canned/etc

enum PantryFilter { have, miss, both }

class PantryView extends StatefulWidget {
  const PantryView({super.key});

  @override
  State<PantryView> createState() => _PantryViewState();
}

class _PantryViewState extends State<PantryView> {
  PantryFilter filter = PantryFilter.both;

  Widget getFilterIcon() {
    if (filter == PantryFilter.have) {
      return const Icon(Icons.done);
    } else if (filter == PantryFilter.miss) {
      return const Icon(Icons.close);
    }
    return const Row(
      children: [
        Icon(Icons.done),
        Icon(Icons.close)
      ],
    );
  }

  Widget getFilterButton() {
    return IconButton(
      icon: getFilterIcon(),
      onPressed: () {
        setState(
          () {
            filter = PantryFilter
                .values[(filter.index + 1) % PantryFilter.values.length];
          },
        );
      },
    );
  }

  // Widget getSearchField() {
  //   return const SizedBox(
  //     width: double.infinity,
  //     height: 40,
  //     child: Center(
  //       child: TextField(),
  //     ),
  //   );
  // }

  Widget buildView() {
    var items = Pantry.instance.getAllItems().toList();
    if (filter == PantryFilter.have) {
      items = items.where((id) => Pantry.instance.inPantry(id)).toList();
    } else if (filter == PantryFilter.miss) {
      items = items.where((id) => !Pantry.instance.inPantry(id)).toList();
    }
    items.sort();
    // (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Scaffold(
      appBar: AppBar(
        // title: getSearchField(),
        actions: [
        // IconButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: () {},
        // ),
        getFilterButton()
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items
                .map((id) => IngredientCard(Pantry.instance.getItem(id)))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Pantry.instance.init(),
        ShoppingList.instance.init(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildView();
        } else {
          return const Scaffold(body: Center(child: Text("LOADING")));
        }
      },
    );
  }
}
