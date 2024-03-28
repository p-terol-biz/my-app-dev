import 'package:flutter/material.dart';
import 'package:zutomayoddeck/Model/cardInDeckObject.dart';

Widget CardInDeckItem(BuildContext context, CardInDeckProperty model,
    Function removeCardInDeckList) {
  return Builder(builder: (BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: GestureDetector(
        child: Image.network(model.cardImageURL),
        onTap: () {
          //deckmodelから削除
          removeCardInDeckList(model);
        },
      ),
    );
  });
}
