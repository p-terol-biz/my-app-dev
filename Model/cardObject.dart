import 'package:myapp/Constant/constant.dart';
import 'package:myapp/Core/responseMessage.dart';
import 'package:myapp/Repository/GetCardItemRepository.dart';
import 'dart:async';

import '../Core/commonConverter.dart';

class CardObject {
  List<CardProperty> cardList;
  ResultProperty resultProperty;

  CardObject({
    List<CardProperty>? cardList, // ?を削除
    ResultProperty? resultProperty, // ?を削除
  })  : cardList = cardList ?? [], // ヌルチェックとデフォルト値を設定
        resultProperty = resultProperty ?? ResultProperty();

  // Get
  Future<List<CardProperty>> getCardList() async {
    GetCardItemRepository getCardItemRepository = GetCardItemRepository();
    String _imagePath = ConnectionString.ImagePath;
    List<String> _zutomayoCardSeasonList = [];
    List<int> _zutomayoCardSeasonLengthList = [];

    _zutomayoCardSeasonList.addAll(ConnectionString.zutomayoCardSeasonList);
    _zutomayoCardSeasonLengthList
        .addAll(ConnectionString.zutomayoCardSeasonLengthList);

    List<Future<dynamic>> futureList = [];

    for (int i = 0; i < _zutomayoCardSeasonList.length; i++) {
      for (int j = 0; j < _zutomayoCardSeasonLengthList[i]; j++) {
        futureList.add(getCardItemRepository.getImagePathUrl(_imagePath +
            _zutomayoCardSeasonList[i] +
            (j + 1).toString() +
            ".jpg"));
      }
    }
    try {
      List<dynamic> results = await Future.wait(futureList);
      for (int i = 0; i < _zutomayoCardSeasonList.length; i++) {
        for (int j = 0; j < _zutomayoCardSeasonLengthList[i]; j++) {
          int index = i * _zutomayoCardSeasonLengthList[i] + j;
          if (results[index] != ResultPropertyConstants.StatusError) {
            cardList.add(CardProperty(
                CardIdFromSeasonAndCharacterNumber(i, j), results[index]));
          }
        }
      }
    } catch (e) {
      //何もしない
    }

    return cardList;
  }
}

class CardProperty {
  final String id;

  final String cardImageURL;

  CardProperty(this.id, this.cardImageURL);
}
