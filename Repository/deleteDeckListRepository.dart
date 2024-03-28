import 'package:zutomayoddeck/Interface/sharedPreferences.dart';
import 'dart:async';

class DeleteDeckListRepository {
  Future<void> deleteDeckList() async {
    Completer completerOfDeleteCardInDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .invalidate("deckModels")
        .then((value) => completerOfDeleteCardInDeckList.complete(value));

    await completerOfDeleteCardInDeckList.future;
    return;
  }
}
