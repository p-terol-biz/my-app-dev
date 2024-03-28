import 'package:zutomayoddeck/Constant/constant.dart';
import 'package:zutomayoddeck/Core/responseMessage.dart';
import 'package:zutomayoddeck/Repository/GetCardInDeckListRepository.dart';
import 'dart:async';
import 'dart:convert';
import 'package:zutomayoddeck/Repository/InsertCardInDeckListRepository.dart';
import '../Repository/deleteCardInDeckListRepository.dart';

class CardInDeckObject {
  List<CardInDeckProperty> cardInDeckList;
  ResultProperty resultProperty;

  CardInDeckObject({
    List<CardInDeckProperty>? cardInDeckList, // ?を削除
    ResultProperty? resultProperty, // ?を削除
  })  : cardInDeckList = cardInDeckList ?? [], // ヌルチェックとデフォルト値を設定
        resultProperty = resultProperty ?? ResultProperty();

  // Get
  Future<List<CardInDeckProperty>> getCardInDeckList() async {
    Completer completerOfGetDeckModels = Completer<String>();
    GetCardInDeckListRepository getCardInDeckListRepository =
        GetCardInDeckListRepository();
    String cardInDeckModels;
    getCardInDeckListRepository.getCardInDeckList().then((value) {
      if (value == ResultPropertyConstants.StatusError) {
        List<CardInDeckProperty> _cardInDeckList = [];
        completerOfGetDeckModels.complete(_cardInDeckList);
      } else {
        completerOfGetDeckModels.complete(value);
      }
    });
    cardInDeckModels = await completerOfGetDeckModels.future;
    if (cardInDeckModels.length <= 0) {
      return cardInDeckList;
    }
    List<dynamic> decodedList = jsonDecode(cardInDeckModels);
    cardInDeckList =
        decodedList.map((json) => CardInDeckProperty.fromJson(json)).toList();

    return cardInDeckList;
  }

  // Set Insert

  Future<ResultProperty> insertOrUpdateCardInDeck(
      String cardInDeckId, String cardId, String cardImageURL) async {
    resultProperty = ResultProperty();

    cardInDeckList = await getCardInDeckList();

    //deckPropertyをIdとして追加
    cardInDeckList.add(CardInDeckProperty(
        cardInDeckId: cardInDeckId,
        cardId: cardId,
        cardImageURL: cardImageURL));

    List<Map<String, dynamic>> jsonDeckList =
        cardInDeckList.map((deck) => deck.toJson()).toList();
    String cardInDeckListString = jsonEncode(jsonDeckList);
    //DBに保存
    try {
      InsertCardInDeckListRepository insertDeckListRepository =
          InsertCardInDeckListRepository();
      await insertDeckListRepository.insertCardInDeckList(cardInDeckListString);
      resultProperty.Status = ResultPropertyConstants.StatusSuccess;
    } catch (e) {
      resultProperty.Status = ResultPropertyConstants.StatusError;
      resultProperty.Meesage = e.toString();
    }

    return resultProperty;
  }

  Future<ResultProperty> deleteCardInDeckList(String cardInDeckId) async {
    resultProperty = ResultProperty();
    cardInDeckList = await getCardInDeckList();

    List<CardInDeckProperty> _cardInDeckList = [];
    cardInDeckList.forEach((element) {
      if (element.cardInDeckId != cardInDeckId) {
        _cardInDeckList.add(CardInDeckProperty(
            cardInDeckId: element.cardInDeckId,
            cardId: element.cardId,
            cardImageURL: element.cardImageURL));
      }
    });

    List<Map<String, dynamic>> jsonDeckList =
        _cardInDeckList.map((deck) => deck.toJson()).toList();
    String cardInDeckListString = jsonEncode(jsonDeckList);
    //DBに保存
    try {
      DeleteCardInDeckListRepository deleteDeckListRepository =
          DeleteCardInDeckListRepository();
      await deleteDeckListRepository.deleteCardInDeckList();

      InsertCardInDeckListRepository insertDeckListRepository =
          InsertCardInDeckListRepository();
      await insertDeckListRepository.insertCardInDeckList(cardInDeckListString);
      resultProperty.Status = ResultPropertyConstants.StatusSuccess;
    } catch (e) {
      resultProperty.Status = ResultPropertyConstants.StatusError;
      resultProperty.Meesage = e.toString();
    }

    return resultProperty;
  }

  Future<ResultProperty> insertOrUpdateCardInDeckList(
      String cardInDeckId, List<CardInDeckProperty> _cardInDeckList) async {
    resultProperty = ResultProperty();

    cardInDeckList = await getCardInDeckList();

    //deckPropertyをIdとして追加
    _cardInDeckList.forEach((element) {
      cardInDeckList.add(CardInDeckProperty(
          cardInDeckId: element.cardInDeckId,
          cardId: element.cardId,
          cardImageURL: element.cardImageURL));
    });

    List<Map<String, dynamic>> jsonDeckList =
        cardInDeckList.map((deck) => deck.toJson()).toList();
    String cardInDeckListString = jsonEncode(jsonDeckList);

    //DBに保存
    try {
      //削除処理
      // await deleteCardInDeckList(cardInDeckId);

      InsertCardInDeckListRepository insertDeckListRepository =
          InsertCardInDeckListRepository();
      await insertDeckListRepository.insertCardInDeckList(cardInDeckListString);
      resultProperty.Status = ResultPropertyConstants.StatusSuccess;
    } catch (e) {
      resultProperty.Status = ResultPropertyConstants.StatusError;
      resultProperty.Meesage = e.toString();
    }

    return resultProperty;
  }
}

class CardInDeckProperty {
  String cardInDeckId;

  String cardId;

  String cardImageURL;

  CardInDeckProperty(
      {required this.cardInDeckId,
      required this.cardId,
      required this.cardImageURL});

  factory CardInDeckProperty.fromJson(Map<String, dynamic> json) {
    return CardInDeckProperty(
      cardInDeckId: json['cardInDeckId'] ?? "",
      cardId: json['cardId'] ?? "",
      cardImageURL: json['cardImageURL'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardInDeckId': cardInDeckId,
      'cardId': cardId,
      'cardImageURL': cardImageURL,
    };
  }
}
