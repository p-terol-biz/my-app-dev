import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../Core/commonConverter.dart';

class InsertFirestoreCardInformation {
  Future<void> insertCardInformation(List<CsvData> csvDataList) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference cardInformation =
        firestore.collection('CardInformation');

    csvDataList.forEach((element) {
      addCardInformation(cardInformation, element);
    });
  }

  Future<void> addCardInformation(
      CollectionReference cardInformation, CsvData csvData) async {
    String cardId = CardIdFromSeasonAndCharacterNumber(
        csvData.Season, csvData.CharacterCardNumber);
    DocumentReference docRef1 = await cardInformation.add({
      'Season': csvData.Season.toString().padLeft(2, '0'),
      'CharacterCardNumber':
          csvData.CharacterCardNumber.toString().padLeft(3, '0'),
      'cardId': cardId,
      'Rarity': csvData.Rarity,
    });
    DocumentReference docRef2 = await cardInformation
        .doc(docRef1.id)
        .collection('CardHistoryProperty')
        .add({
      'HistoryId': csvData.HistoryId,
      'CardName': csvData.CardName,
      'CardAttributeList': csvData.CardAttributeList,
      'CardType': csvData.CardType,
      'MusicTitleList': csvData.MusicTitleList,
      'CardAbility': csvData.CardAbilityList,
      'Supplement': csvData.Supplement,
      'cardId': cardId,
    });

    await cardInformation
        .doc(docRef1.id)
        .collection('CardHistoryProperty')
        .doc(docRef2.id)
        .collection('CardPowerProperty')
        .add({
      'PowerCost': csvData.PowerCost,
      'SendToPower': csvData.SendToPower,
      'NightPower': csvData.NightPower,
      'DayPower': csvData.DayPower,
      'NightAndDayCount': csvData.NightPower,
      'cardId': cardId,
    });
    print(cardInformation);
  }
}

class CsvData {
  final int Season;
  final int CharacterCardNumber;
  final String Rarity;
  final String HistoryId;
  final String CardName;
  final List<String> CardAttributeList;
  final String CardType;
  final int PowerCost;
  final int SendToPower;
  final int NightPower;
  final int DayPower;
  final int NightAndDayCount;
  final List<String> MusicTitleList;
  final List<String> CardAbilityList;
  final String Supplement;

  CsvData(
      this.Season,
      this.CharacterCardNumber,
      this.Rarity,
      this.HistoryId,
      this.CardName,
      this.CardAttributeList,
      this.CardType,
      this.PowerCost,
      this.SendToPower,
      this.NightPower,
      this.DayPower,
      this.NightAndDayCount,
      this.MusicTitleList,
      this.CardAbilityList,
      this.Supplement);
}
