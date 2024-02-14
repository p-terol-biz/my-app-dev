import 'package:myapp/Constant/constant.dart';
import 'package:myapp/Core/responseMessage.dart';
import 'package:myapp/Repository/GetDeckListRepository.dart';
import 'dart:async';
import 'dart:convert';
import 'package:myapp/Repository/InsertDeckListRepository.dart';

class DeckObject {
  List<DeckProperty> deckList;
  ResultProperty resultProperty;

  DeckObject({
    List<DeckProperty>? deckList, // ?を削除
    ResultProperty? resultProperty, // ?を削除
  })  : deckList = deckList ?? [], // ヌルチェックとデフォルト値を設定
        resultProperty = resultProperty ?? ResultProperty();

  // Get
  Future<List<DeckProperty>> getDeckList() async {
    Completer completerOfGetDeckModels = Completer<String>();
    // DBからStringを取得
    GetDeckListRepository getDeckListRepository = GetDeckListRepository();
    String deckModels;
    List<DeckProperty> deckList = [];
    try {
      getDeckListRepository.getDeckList().then((value) {
        if (value == ResultPropertyConstants.StatusError) {
          completerOfGetDeckModels.complete(deckList);
        } else {
          completerOfGetDeckModels.complete(value);
        }
      });
    } catch (e) {
      return deckList;
    }

    deckModels = await completerOfGetDeckModels.future;
    // StringからList<DeckProperty>
    if (deckModels.length <= 0) {
      return deckList;
    }
    List<dynamic> decodedList = jsonDecode(deckModels);
    deckList = decodedList.map((json) => DeckProperty.fromJson(json)).toList();

    return deckList;
  }

  // Set Insert
  Future<ResultProperty> insertOrUpdateDeckList(String deckId, String title,
      String deckTopImageURL, int numberOfCards) async {
    resultProperty = ResultProperty();
    deckList = await getDeckList();

    //deckPropertyをIdとして追加
    int indexId = deckList.indexWhere((element) => element.deckId == deckId);
    if (indexId > 0) {
      // デッキの編集
      deckList[indexId].title = title;
      deckList[indexId].deckTopImageURL = deckTopImageURL;
      deckList[indexId].numberOfCards = numberOfCards;
    } else {
      deckList.add(DeckProperty(
          deckId: deckId,
          title: title,
          deckTopImageURL: deckTopImageURL,
          numberOfCards: numberOfCards));
    }
    List<Map<String, dynamic>> jsonDeckList =
        deckList.map((deck) => deck.toJson()).toList();
    String deckListString = jsonEncode(jsonDeckList);
    //DBに保存
    try {
      InsertDeckListRepository insertDeckListRepository =
          InsertDeckListRepository();
      await insertDeckListRepository.insertDeckList(deckListString);
      resultProperty.Status = ResultPropertyConstants.StatusSuccess;
    } catch (e) {
      resultProperty.Status = ResultPropertyConstants.StatusError;
      resultProperty.Meesage = e.toString();
    }

    return resultProperty;
  }
}

class DeckProperty {
  final String deckId;
  String title;
  String deckTopImageURL;
  int numberOfCards;

  DeckProperty(
      {required this.deckId,
      required this.title,
      required this.deckTopImageURL,
      required this.numberOfCards});

  factory DeckProperty.fromJson(Map<String, dynamic> json) {
    return DeckProperty(
      deckId: json['deckId'] ?? "",
      title: json['title'] ?? "",
      deckTopImageURL: json['deckTopImageURL'] ?? "",
      numberOfCards: json['numberOfCards'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deckId': deckId,
      'title': title,
      'deckTopImageURL': deckTopImageURL,
      'numberOfCards': numberOfCards,
    };
  }
}
