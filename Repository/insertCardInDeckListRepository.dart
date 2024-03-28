import 'package:zutomayoddeck/Interface/sharedPreferences.dart';
import 'dart:async';

class InsertCardInDeckListRepository {
  Future<void> insertCardInDeckList(String cardInDeckListString) async {
    Completer completerOfInsertCardInDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .save("cardInDeckModels", cardInDeckListString)
        .then((value) => {completerOfInsertCardInDeckList.complete(value)});

    await completerOfInsertCardInDeckList.future;
    return;
  }
}
