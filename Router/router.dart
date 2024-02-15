import 'package:flutter/material.dart';
import 'package:myapp/ViewModel/cardSearchFormState.dart';
import 'package:myapp/ViewModel/deckDetailState.dart';
import '../View/cardSearchFormWidget.dart';
import '../ViewModel/deckListState.dart';

class DeckListViewRouter {
  push(BuildContext context) {
    // 画面 B へ進む
    // context.push('/deckDetail');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeckListApp()),
    );
  }
}

class DeckDetailViewRouter {
  push(BuildContext context, String mode, String deckId, String title,
      Function updateScreen) {
    // 画面 B へ進む
    // context.push('/deckDetail');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeckDetail(
              mode: mode,
              deckId: deckId,
              title: title,
              updateScreen: updateScreen)),
    );
  }
}

// class CardSearchFormRouter {
//   push(BuildContext context) {
//     // 画面 B へ進む
//     // context.push('/deckDetail');
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CardSearchFormApp()),
//     );
//   }
// }
