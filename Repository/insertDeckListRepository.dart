import 'package:myapp/Interface/sharedPreferences.dart';
import 'dart:async';

class InsertDeckListRepository {
  Future<void> insertDeckList(String deckListString) async {
    Completer completerOfInsertDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .save("deckModels", deckListString)
        .then((value) => {completerOfInsertDeckList.complete(value)});

    await completerOfInsertDeckList.future;
    return;
  }
}
