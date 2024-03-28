import 'package:zutomayoddeck/Interface/sharedPreferences.dart';
import 'dart:async';

class GetCardInDeckListRepository {
  Future<String> getCardInDeckList() async {
    Completer completerOfGetCardInDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .getId("cardInDeckModels")
        .then((value) => {completerOfGetCardInDeckList.complete(value)});

    return await completerOfGetCardInDeckList.future;
  }
}
