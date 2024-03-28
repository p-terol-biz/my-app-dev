class ResultPropertyConstants {
  static const String StatusError = "ERROR";
  static const String StatusSuccess = "SUCCESS";
}

class ConnectionString {
  static const String ImagePath =
      "gs://zutomayocard-6280a.appspot.com/Img/Card/";

  static const String ZutomayoCard1st =
      "1st/ZUTOMAYO_CARD_THE_BATTLE_BEGINS_1_";

  static const String ZutomayoCard2nd =
      "2nd/ZUTOMAYO_CARD_THE_BATTLE_BEGINS_2_";

  static const List<String> zutomayoCardSeasonList = [
    ZutomayoCard1st,
    ZutomayoCard2nd
  ];

  static const List<int> zutomayoCardSeasonLengthList = [104, 0]; //[104, 104];
}

class DeckType {
  static const String CreateDeck = "CreateDeck";
  static const String EditDeck = "EditDeck";
}
