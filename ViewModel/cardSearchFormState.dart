import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ViewModel/searchConditionState.dart';

import '../Core/commonConverter.dart';

class SearchState {
  Set<String> searchResults = {};
  Map<String, bool> IsUsingList_Attribute = {};
  Map<String, bool> IsUsingList_CardType = {};
  Map<String, bool> IsUsingList_Cost = {};

  void updateIsUsingList_Attribute(String key) {
    if (IsUsingList_Attribute[key] == true) {
      IsUsingList_Attribute[key] = false;
    } else {
      IsUsingList_Attribute[key] = true;
    }
  }

  void updateIsUsingList_CardType(String key) {
    if (IsUsingList_Attribute[key] == true) {
      IsUsingList_Attribute[key] = false;
    } else {
      IsUsingList_Attribute[key] = true;
    }
  }

  void updateIsUsingList_Cost(String key) {
    if (IsUsingList_Attribute[key] == true) {
      IsUsingList_Attribute[key] = false;
    } else {
      IsUsingList_Attribute[key] = true;
    }
  }

  SearchState() {
    IsUsingList_Attribute["Dark"] = false;
    IsUsingList_Attribute["Fire"] = false;
    IsUsingList_Attribute["Thunder"] = false;
    IsUsingList_Attribute["Storm"] = false;
    IsUsingList_CardType["Character"] = false;
    IsUsingList_CardType["Enchant"] = false;
    IsUsingList_CardType["Erea Enchant"] = false;
    IsUsingList_Cost["0"] = false;
    IsUsingList_Cost["1"] = false;
    IsUsingList_Cost["2"] = false;
    IsUsingList_Cost["3"] = false;
    IsUsingList_Cost["4"] = false;
    IsUsingList_Cost["5"] = false;
    IsUsingList_Cost["6"] = false;
    IsUsingList_Cost["7+"] = false;
  }

  // void updateSearchResults(Set<String> results) {
  //   searchResults = results;
  // }
}

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

class CustomSearchDelegate extends SearchDelegate<String> {
  SearchConditionList searchConditionList = SearchConditionList();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Build actions for the AppBar (e.g., clear query button)
    return [
      // IconButton(
      //   icon: Icon(Icons.search),
      //   onPressed: () async {
      //     List<Map<String, dynamic>> dataList = await fetchDataFromFirestore();
      //     print("dataList[0]");
      //     print(dataList[0]);
      //     // queryの単語でFirestoreのDBを検索
      //     // final crdHistoryPropertyQuery = FirebaseFirestore.instance
      //     //     .collectionGroup('CardHistoryProperty')
      //     //     .where("CardName", isGreaterThanOrEqualTo: query)
      //     //     .snapshots();

      //     // crdHistoryPropertyQuery.

      //     // crdHistoryPropertyQuery.map((DocumentSnapshot document) {
      //     //     Map<String, dynamic> data =
      //     //         document.data()! as Map<String, dynamic>;
      //     //     return ListTile(
      //     //       title: Text(data['text']),
      //     //     );
      //     //   }).toList(),

      //     // for (int i = 0; i < crdHistoryPropertyQuery.docs.length; i++) {
      //     //   print(cardInformationQuery.docs[i].data());
      //     // }
      //   },
      // ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirestore(
      Map<String, List<String>> CardHistoryList) async {
    List<Map<String, dynamic>> dataList = [];

    try {
      print("query");
      print(query);

      // var crdHistoryPropertyQuery =
      //     FirebaseFirestore.instance.collectionGroup('CardHistoryProperty');

      Query<Map<String, dynamic>> querymap = await FirebaseFirestore.instance
          .collectionGroup('CardHistoryProperty');
      // .where("CardName", isGreaterThanOrEqualTo: query)
      // .get();

      CardHistoryList["CardAttributeList"]!.forEach((element) {
        querymap = querymap.where("CardAttributeList", arrayContains: element);
      });

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await querymap.get();

      // データをリストに格納
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        dataList.add(data);
      }

      // データを内部で保持したい場合はここで dataList を使用できます
      print('Data List: $dataList');
    } catch (e) {
      print('Error fetching data: $e');
    }

    return dataList;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Build leading icon for the AppBar (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results based on the current query
    // 検索でEnterを押されるときどうする
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Build suggestions based on the current query
    // return Center(
    //   child: Text('Suggestions for: $query'),
    // );

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

        // Expanded(
        //     child: ListView(
        //   children: <Widget>[
        //     ListTile(
        //       title: Text(
        //         'Attribute',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Container(
        //         child: Center(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: IsUsingList_Attribute.keys.map((key) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Column(
        //                   children: <Widget>[
        //                     Checkbox(
        //                       value: IsUsingList_Attribute[key],
        //                       onChanged: (value) {
        //                         IsUsingList_Attribute[key] = value!;
        //                       },
        //                     ),
        //                     Text(key)
        //                   ],
        //                 ),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Card Type',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Container(
        //         child: Center(
        //           child: Row(
        //             children: IsUsingList_CardType.keys.map((key) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Column(
        //                   children: <Widget>[
        //                     Checkbox(
        //                       value: IsUsingList_CardType[key],
        //                       onChanged: (value) {
        //                         IsUsingList_Attribute[key] = value!;
        //                       },
        //                     ),
        //                     Text(key)
        //                   ],
        //                 ),
        //               );
        //             }).toList(),
        //             mainAxisAlignment: MainAxisAlignment.center,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Cost',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Container(
        //         child: Center(
        //           child: Row(
        //             children: IsUsingList_Cost.keys.map((key) {
        //               return Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: InkWell(
        //                     borderRadius:
        //                         const BorderRadius.all(Radius.circular(32)),
        //                     onTap: () {
        //                       // ここに tap されたときの処理
        //                       if (IsUsingList_Cost[key] == true) {
        //                         IsUsingList_Cost[key] = false;
        //                       } else {
        //                         IsUsingList_Cost[key] = true;
        //                       }
        //                       print(key);
        //                     },
        //                     child: AnimatedContainer(
        //                       duration: const Duration(milliseconds: 200),
        //                       padding: const EdgeInsets.symmetric(
        //                           horizontal: 16, vertical: 8),
        //                       decoration: BoxDecoration(
        //                         borderRadius:
        //                             const BorderRadius.all(Radius.circular(32)),
        //                         border: Border.all(
        //                           width: 2,
        //                           color: Colors.pink,
        //                         ),
        //                         color:
        //                             IsUsingList_Cost[key]! ? Colors.pink : null,
        //                       ),
        //                       child: Text(
        //                         key,
        //                         style: TextStyle(
        //                           color: IsUsingList_Cost[key]!
        //                               ? Colors.white
        //                               : Colors.pink,
        //                           fontWeight: FontWeight.bold,
        //                         ),
        //                       ),
        //                     ),
        //                   ));
        //             }).toList(),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Send To Power',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Night Day Count',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Night Power',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Day Power',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Rarity',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //     Divider(),
        //     ListTile(
        //       title: Text(
        //         'Ability',
        //         style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Center(
        //         child: Text("Test detail 003"),
        //       ),
        //     ),
        //   ],
        // ))
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
                    // print(searchConditionList.IsUsingList_CardAttribute);
                    Map<String, List<String>> CardHistoryList = {};
                    searchConditionList.IsUsingList_CardAttribute.forEach(
                        (key, value) {
                      if (value) {
                        List<String> targetCardHistoryList = [];
                        if (CardHistoryList["CardAttributeList"] == null) {
                          CardHistoryList["CardAttributeList"] = [];
                        } else {
                          targetCardHistoryList =
                              CardHistoryList["CardAttributeList"]!;
                        }
                        targetCardHistoryList
                            .add(CardAttributeIdFromAttributeName(key));
                        CardHistoryList["CardAttributeList"] =
                            targetCardHistoryList;
                      }
                    });

                    // var crdHistoryPropertyQuery = FirebaseFirestore.instance
                    //     .collectionGroup('CardHistoryProperty');

                    // CardHistoryList["CardAttributeList"]!.forEach((element) {
                    //   crdHistoryPropertyQuery = crdHistoryPropertyQuery
                    //       .where("CardAttributeList", arrayContains: element);
                    // });

                    List<Map<String, dynamic>> dataList =
                        await fetchDataFromFirestore(CardHistoryList);

                    for (int i = 0; i < dataList.length; i++) {
                      print(dataList[i]);
                    }

                    // for (int i = 0;
                    //     i < crdHistoryPropertyQuery.
                    //     i++) {
                    //   print(cardInformationQuery.docs[i].data());
                    // }
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
}
