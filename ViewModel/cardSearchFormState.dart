import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zutomayoddeck/ViewModel/searchConditionState.dart';

import '../Core/commonConverter.dart';
import '../Router/router.dart';

class SearchConditionList {
  Map<String, bool> IsUsingList_CardAttribute = {};
  Map<String, bool> IsUsingList_CardType = {};
  Map<String, bool> IsUsingList_Cost = {};
  Map<String, bool> IsUsingList_SendToPower = {};
  Map<String, bool> IsUsingList_NightDayCount = {};
  Map<String, bool> IsUsingList_Rarity = {};
  List<bool> IsUsingList_NightPower = [];
  List<bool> IsUsingList_DayPower = [];
  List<double> NumberOf_NightPower = [];
  List<double> NumberOf_DayPower = [];
}

class CustomSearchDelegate extends SearchDelegate {
  final String mode;
  final String deckId;
  final String title;
  final Function updateScreen;

  CustomSearchDelegate(
      {required this.mode,
      required this.deckId,
      required this.title,
      required this.updateScreen});

  SearchConditionList searchConditionList = SearchConditionList();
  List<Map<String, dynamic>> dataList = [];
  List<String> dataIdList = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Build actions for the AppBar (e.g., clear query button)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  Query<Map<String, dynamic>> getQueryMap(
      String key, Map<String, List<String>> value) {
    Map<String, Query<Map<String, dynamic>>> queryMap = {};
    print("333");

    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collectionGroup(key);
    // queryMap[key] = FirebaseFirestore.instance.collectionGroup(key);
/*
    value.forEach((key2, value2) async {
      switch (key2) {
        case 'CardAttributeList':
          for (String value3 in value2) {
            print("key: " + key2 + " value3: " + value3);

            queryMap[key1] =
                await queryMap[key1]!.where(key2, arrayContains: value3);
          }

          break;
        // default:
        // queryMap[key1] =
        //     queryMap[key1]!.where(key2, arrayContains: value2);
      }
      // print("key: " + key2 + " value2: " + value2.toString());
      // print("InFunction fetchDataFromFirestore key " +
      //     key1 +
      //     " queryMap: " +
      //     queryMap[key1].toString());
    });
    */
    queryMap["CardHistoryProperty"] =
        query.where("CardAttributeList", arrayContains: "4");
    print("333-fin");

    // return queryMap;
    return query.where("CardAttributeList", arrayContains: "4");
  }

  Future<Map<String, QuerySnapshot<Map<String, dynamic>>>> getQuerySnapshotMap(
      Map<String, Map<String, List<String>>> whereList) async {
    Map<String, QuerySnapshot<Map<String, dynamic>>> querySnapshotMap = {};
    Map<String, Query<Map<String, dynamic>>> queryMap = {};
    print("222");

    // Completer completer = Completer<String>();

    whereList.forEach((key, value) async {
      // getQueryMap(key, value).then((_queryMap) {
      //   completer.complete(_queryMap);
      // });
      // queryMap[key] = await completer.future as Query<Map<String, dynamic>>;
      queryMap["CardHistoryProperty"] = getQueryMap(key, value);
      // queryMap[key] = (getQueryMap(key, value)) as Query<Map<String, dynamic>>;
      // querySnapshotMap[key1] = await queryMap[key1]!.get();

      querySnapshotMap["CardHistoryProperty"] =
          await queryMap["CardHistoryProperty"]!.get();
    });
    print("222-fin");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await queryMap["CardHistoryProperty"]!.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      print("bbb");

      Map<String, dynamic> data = await document.data() as Map<String, dynamic>;
      print("ccc");
      print("data: " + data["cardId"].toString());
      // _dataIdList.add(await data["cardId"].toString());
    }
    // print("_dataIdList: $_dataIdList");

    return querySnapshotMap;
  }

  Future<List<String>> getDataIdList(
      Map<String, QuerySnapshot<Map<String, dynamic>>> querySnapshotMap) async {
    List<String> dataIdList = [];
    querySnapshotMap.forEach((key, value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in await querySnapshotMap[key]!.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        dataIdList.add(data["cardId"].toString());
      }
    });
    return dataIdList;
  }

  Future<void> fetchDataFromFirestore(BuildContext context,
      Map<String, Map<String, List<String>>> whereList) async {
    try {
      // Map<String, Query<Map<String, dynamic>>> queryMap = {};
      Map<String, QuerySnapshot<Map<String, dynamic>>> querySnapshotMap = {};
      // Query<Map<String, dynamic>>? _queryMap = null;
      // QuerySnapshot<Map<String, dynamic>>? _querySnapshotMap = null;
      List<String> _dataIdList = [];

      // Query<Map<String, dynamic>> _queryMap = await FirebaseFirestore.instance
      //     .collectionGroup("CardHistoryProperty")
      //     .where("CardAttributeList", arrayContains: "4");

      // QuerySnapshot<Map<String, dynamic>> _querySnapshotMap =
      //     await _queryMap.get();
      // print("111");
      // querySnapshotMap = await getQuerySnapshotMap(whereList);
      // print("111-fin");
      List<Query<Map<String, dynamic>>> queryList = [];
      whereList.forEach((key, value) {
        switch (key) {
          case 'CardHistoryProperty':
            value.forEach((cardHistoryKey, cardHistoryValue) {
              switch (cardHistoryKey) {
                case 'CardAttributeList':
                  if (cardHistoryValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardHistoryValue) {
                      query =
                          query.where("CardAttributeList", arrayContains: val);
                    }
                    queryList.add(query);
                  }

                  break;
                case 'CardType':
                  if (cardHistoryValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardHistoryValue) {
                      query = query.where("CardType", isEqualTo: val);
                    }
                    queryList.add(query);
                  }
                  break;
                default:
              }
            });
            break;
          case 'CardPowerProperty':
            value.forEach((cardPowerKey, cardPowerValue) {
              switch (cardPowerKey) {
                case 'PowerCost':
                  if (cardPowerValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardPowerValue) {
                      if (val == "7+") {
                        query = query.where("PowerCost",
                            isGreaterThanOrEqualTo: "7");
                      } else {
                        query = query.where("PowerCost", isEqualTo: val);
                      }
                    }
                    queryList.add(query);
                  }
                  break;
                case 'SendToPower':
                  if (cardPowerValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardPowerValue) {
                      if (val == "4+") {
                        query = query.where("SendToPower",
                            isGreaterThanOrEqualTo: "4");
                      } else {
                        query = query.where("SendToPower", isEqualTo: val);
                      }
                    }
                    queryList.add(query);
                  }
                  break;
                case 'NightDayCount':
                  if (cardPowerValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardPowerValue) {
                      if (val == "4+") {
                        query = query.where("NightDayCount",
                            isGreaterThanOrEqualTo: "4");
                      } else {
                        query = query.where("NightDayCount", isEqualTo: val);
                      }
                    }
                    queryList.add(query);
                  }
                  break;

                case 'NightPower':
                  if (cardPowerValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardPowerValue) {
                      query = query.where("NightPower", isEqualTo: val);
                    }
                    queryList.add(query);
                  }
                  break;
                case 'DayPower':
                  if (cardPowerValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardPowerValue) {
                      query = query.where("DayPower", isEqualTo: val);
                    }
                    queryList.add(query);
                  }
                  break;
                default:
              }
            });
            break;
          case 'CardInformation':
            value.forEach((cardInformationKey, cardInformationValue) {
              switch (cardInformationKey) {
                case 'Rarity':
                  if (cardInformationValue.isNotEmpty) {
                    Query<Map<String, dynamic>> query;
                    query = FirebaseFirestore.instance.collectionGroup(key);

                    for (var val in cardInformationValue) {
                      query = query.where("Rarity", isEqualTo: val);
                    }
                    queryList.add(query);
                  }
                  break;
                default:
              }
            });
            break;
          default:
            print("default !");
        }
      });

      if (queryList.length > 0) {
        for (int i = 0; i < queryList.length; i++) {
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await queryList[i].get();
          List<String> _dataIdList = [];

          for (QueryDocumentSnapshot<Map<String, dynamic>> document
              in querySnapshot.docs) {
            Map<String, dynamic> data = document.data();

            _dataIdList.add(data["cardId"].toString());
          }
          if (i == 0) {
            dataIdList.addAll(_dataIdList);
          } else {
            dataList = dataList
                .where((element) => _dataIdList.contains(element))
                .toSet()
                .toList();
          }
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Build leading icon for the AppBar (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Container());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results based on the current query
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text('Suggestions for: $query'),
                ),
                SearchConditionWidget(searchConditionList: searchConditionList),
              ],
            ),
          ),
        ),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    const dimension = 8.0;
    final style = OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 44.0),
    );

    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(dimension),
          child: Row(
            children: [
              Flexible(
                child: OutlinedButton(
                  style: style,
                  onPressed: () {
                    // context.router.pop();
                  },
                  child: const Text('-'),
                ),
              ),
              const SizedBox(width: dimension),
              Flexible(
                child: OutlinedButton(
                  style: style,
                  onPressed: () async {
                    Map<String, Map<String, List<String>>> whereList = {};
                    // Map<String, List<String>> CardHistoryList = {};
                    whereList["CardHistoryProperty"] = {};
                    whereList["CardPowerProperty"] = {};
                    whereList["CardInformation"] = {};

                    whereList["CardHistoryProperty"]?["CardAttributeList"] =
                        getCardHistoryList(
                            targetMapList:
                                searchConditionList.IsUsingList_CardAttribute,
                            convertKeyFunction:
                                CardAttributeIdFromCardAttributeName);

                    whereList["CardHistoryProperty"]?["CardType"] =
                        getCardHistoryList(
                            targetMapList:
                                searchConditionList.IsUsingList_CardType,
                            convertKeyFunction: CardTypeIdFromCardTypeName);

                    whereList["CardPowerProperty"]?["PowerCost"] =
                        getCardPowerList(
                            targetMapList:
                                searchConditionList.IsUsingList_Cost);

                    whereList["CardPowerProperty"]?["SendToPower"] =
                        getCardPowerList(
                            targetMapList:
                                searchConditionList.IsUsingList_SendToPower);

                    whereList["CardPowerProperty"]?["NightDayCount"] =
                        getCardPowerList(
                            targetMapList:
                                searchConditionList.IsUsingList_NightDayCount);

                    whereList["CardPowerProperty"]?["NightPower"] =
                        getCardNightDayPowerList(
                            targetList:
                                searchConditionList.IsUsingList_NightPower,
                            targetNightDayPowerList:
                                searchConditionList.NumberOf_NightPower);

                    whereList["CardPowerProperty"]?["DayPower"] =
                        getCardNightDayPowerList(
                            targetList:
                                searchConditionList.IsUsingList_DayPower,
                            targetNightDayPowerList:
                                searchConditionList.NumberOf_DayPower);

                    whereList["CardInformation"]?["Rarity"] =
                        getCardHistoryList(
                            targetMapList:
                                searchConditionList.IsUsingList_Rarity);

                    // searchConditionList.IsUsingList_CardAttribute.forEach(
                    //     (key, value) {
                    //   if (value) {
                    //     List<String> targetCardHistoryList = [];
                    //     if (CardHistoryList["CardAttributeList"] == null) {
                    //       CardHistoryList["CardAttributeList"] = [];
                    //     } else {
                    //       targetCardHistoryList =
                    //           CardHistoryList["CardAttributeList"]!;
                    //     }
                    //     targetCardHistoryList
                    //         .add(CardAttributeIdFromAttributeName(key));
                    //     CardHistoryList["CardAttributeList"] =
                    //         targetCardHistoryList;
                    //   }
                    // });

                    await fetchDataFromFirestore(context, whereList);
                    DeckDetailViewRouter deckDetailViewRouter =
                        DeckDetailViewRouter();

                    deckDetailViewRouter.push(
                        context, mode, deckId, title, updateScreen, dataIdList);
                  },
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> getCardHistoryList(
      {Map<String, bool>? targetMapList, Function? convertKeyFunction}) {
    //targetMapListのTrueになっているKeyを取得する
    //取得したKeyのListを返す
    List<String> targetCardHistoryList = [];

    if (targetMapList != null) {
      targetMapList.forEach((key, value) {
        if (value) {
          if (convertKeyFunction != null) {
            targetCardHistoryList.add(convertKeyFunction(key));
          } else {
            targetCardHistoryList.add(key);
          }
        }
      });
    }
    return targetCardHistoryList;
  }

  List<String> getCardPowerList(
      {Map<String, bool>? targetMapList, Function? convertKeyFunction}) {
    //targetMapListのTrueになっているKeyを取得する
    //取得したKeyのListを返す
    List<String> targetCardHistoryList = [];

    if (targetMapList != null) {
      targetMapList.forEach((key, value) {
        if (value) {
          if (convertKeyFunction != null) {
            targetCardHistoryList.add(convertKeyFunction(key));
          } else {
            targetCardHistoryList.add(key);
          }
        }
      });
    }
    return targetCardHistoryList;
  }

  List<String> getCardNightDayPowerList(
      {List<bool>? targetList, List<double>? targetNightDayPowerList}) {
    //targetMapListのTrueになっているKeyを取得する
    //取得したKeyのListを返す
    List<String> targetCardHistoryList = [];

    if (targetList != null) {
      targetList.forEach((element) {
        if (element) {
          if (targetNightDayPowerList != null) {
            targetCardHistoryList.add(targetNightDayPowerList[0].toString());
          }
        }
      });
    }
    return targetCardHistoryList;
  }
}
