import 'package:myapp/Interface/sharedPreferences.dart';
import 'dart:async';

class DeleteCardInDeckListRepository {
  Future<void> deleteCardInDeckList() async {
    Completer completerOfDeleteCardInDeckList = Completer<String>();

    final IdRepository idRepository = IdRepository();
    idRepository
        .invalidate("cardInDeckModels")
        .then((value) => completerOfDeleteCardInDeckList.complete(value));

    await completerOfDeleteCardInDeckList.future;
    return;
  }
}
