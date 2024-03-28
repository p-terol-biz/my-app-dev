import 'package:zutomayoddeck/Interface/sharedPreferences.dart';
import 'dart:async';

class GetDeckListRepository {
  Future<String> getDeckList() async {
    Completer completerOfGetDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .getId("deckModels")
        .then((value) => {completerOfGetDeckList.complete(value)});

    return await completerOfGetDeckList.future;
  }
}
