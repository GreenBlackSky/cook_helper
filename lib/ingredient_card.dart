import 'package:flutter/material.dart';
import 'pantry.dart';

class IngredientCard extends StatefulWidget {
  final String ingredient;

  const IngredientCard(this.ingredient, {super.key});

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  Widget getBetterStockWidget(bool betterStock) {
    if (betterStock) {
      return const Icon(Icons.home);
    } else {
      return const Icon(Icons.store);
    }
  }

  Widget getHasAtHomeIcon(bool hasAtHome) {
    if (hasAtHome) {
      return const Icon(Icons.done, color: Colors.green);
    } else {
      return const Icon(Icons.close, color: Colors.red,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            setState(() {
              PANTRY.reverseHaveAtHome(widget.ingredient);
            });
          },
          child: SizedBox(
              width: 500,
              height: 60,
              child: Center(
                  child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(widget.ingredient),
                  )),
                  Expanded(child: getBetterStockWidget(PANTRY.betterStock(widget.ingredient))),
                  Expanded(child: getHasAtHomeIcon(PANTRY.haveAtHome(widget.ingredient)))
                ],
              ))),
        ),
      ),
    );
  }
}
