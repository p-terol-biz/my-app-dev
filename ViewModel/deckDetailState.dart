import 'package:flutter/material.dart';
import 'package:myapp/Model/deckObject.dart';
import 'package:myapp/View/cardItemWidget.dart';
import 'package:myapp/View/cardInDeckItemWidget.dart';
import 'package:myapp/Model/cardInDeckObject.dart';
import 'package:myapp/Model/cardObject.dart';
import 'package:myapp/Component/dialogComponent.dart';
import 'package:myapp/Router/router.dart';

import 'dart:async';
import 'package:uuid/uuid.dart';

import '../Constant/constant.dart';

class DeckDetail extends StatefulWidget {
  final String mode;
  final String deckId;
  final String title;
  final Function updateScreen;

  const DeckDetail(
      {Key? key,
      required this.mode,
      required this.deckId,
      required this.title,
      required this.updateScreen})
      : super(key: key);

  // push(BuildContext context) {
  //   // 画面 B へ進む
  //   DeckDetailViewRouter deckDetailViewRouter = DeckDetailViewRouter();
  //   deckDetailViewRouter.push(context, "createDeck", updateScreen);
  // }

  @override
  _DeckDetailState createState() => _DeckDetailState(
      mode: mode, deckId: deckId, title: title, updateScreen: updateScreen);
}

class _DeckDetailState extends State<DeckDetail>
    with AutomaticKeepAliveClientMixin {
  final String mode;
  final String deckId;
  final String title;
  final Function updateScreen;

  _DeckDetailState(
      {required this.mode,
      required this.deckId,
      required this.title,
      required this.updateScreen});

  List<CardInDeckProperty> cardInDeckList = [];
  List<CardProperty> cardList = [];
  List<String> notAllowedInDeckList = [];
  var cardInDeckIdURI = "";

  void setNotAllowedInDeckList(
      List<CardInDeckProperty> cardInDeckList, String id) {
    int count = cardInDeckList.where((element) => element.cardId == id).length;
    if (count >= 2) {
      if (!notAllowedInDeckList.contains(id)) {
        notAllowedInDeckList.add(id);
      }
    }
  }

  void removeCardInDeckList(CardInDeckProperty model) {
    setState(() {
      int removeCardIndex =
          cardInDeckList.indexWhere((x) => x.cardId == model.cardId);
      cardInDeckList.removeAt(removeCardIndex);
      notAllowedInDeckList.remove(model.cardId);
    });
  }

  void addCardInDeckList(String cardInDeckId, String id, String cardImageURL) {
    setState(() {
      cardInDeckList.add(CardInDeckProperty(
          cardInDeckId: cardInDeckId, cardId: id, cardImageURL: cardImageURL));

      setNotAllowedInDeckList(cardInDeckList, id);
      // int count =
      //     cardInDeckList.where((element) => element.cardId == id).length;
      // if (count >= 2) {
      //   notAllowedInDeckList.add(id);
      // }
    });
  }

  // Future<void> someAsyncMethod() async {
  //   // AAA の非同期関数を呼び出す
  // }

  Future<void> setCardInDeckList() async {
    if (mode == DeckType.CreateDeck) {
      //何もしない
    } else if (mode == DeckType.EditDeck) {
      CardInDeckObject cardInDeckObject = CardInDeckObject();
      List<CardInDeckProperty> allCardInDeckList =
          await cardInDeckObject.getCardInDeckList();
      cardInDeckList.addAll(allCardInDeckList
          .where((element) => element.cardInDeckId == deckId)
          .toList());
      cardInDeckList.forEach((element) {
        setNotAllowedInDeckList(cardInDeckList, element.cardId);
      });
    }
    setState(() {});
  }

  Future<void> setCardList() async {
    CardObject cardObject = CardObject();
    cardList = await cardObject.getCardList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setCardInDeckList();
    setCardList();
    if (mode == DeckType.CreateDeck) {
      cardInDeckIdURI = Uuid().v4().toString();
    } else if (mode == DeckType.EditDeck) {
      cardInDeckIdURI = deckId;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.purple,
      title: const Text('デッキ作成'),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () => {
            //
          },
        ),
      ],
    );
    if (mode == DeckType.CreateDeck) {
      appBar = AppBar(
        backgroundColor: Colors.purple,
        title: const Text('デッキ作成'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => {
              //
            },
          ),
        ],
      );
    } else if (mode == DeckType.EditDeck) {
      appBar = AppBar(
        backgroundColor: Colors.purple,
        title: const Text('デッキ編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => {
              //
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      body: Row(children: <Widget>[
        Expanded(
            flex: 6,
            child: Container(
                child: SizedBox(
                    child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        padding: EdgeInsets.all(10),
                        itemCount: cardList.length,
                        itemBuilder: (c, i) => CardItem(c, cardList[i],
                            notAllowedInDeckList, cardInDeckIdURI, mode))))),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.grey,
            child: DragTarget(builder: (context, accepted, rejected) {
              return Container(child: SizedBox(child: Builder(
                builder: (BuildContext context) {
                  return ListView.builder(
                      itemCount: cardInDeckList.length,
                      addAutomaticKeepAlives: true,
                      itemExtent: 100,
                      itemBuilder: (c, i) => CardInDeckItem(
                          c, cardInDeckList[i], removeCardInDeckList));
                },
              )));
            }, onAccept: (CardProperty data) {
              addCardInDeckList(cardInDeckIdURI, data.id, data.cardImageURL);
            }),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // DeckModelsObject deckModelsObject = new DeckModelsObject();
          // final todo = new UserDeckInformation('deck001', 'cardindeck001',
          //     'card001', CardModels[0].cardImageURL);
          // deckModelsObject.insertDatabase(todo);
          // final allRows = await deckModelsObject.getUserDeckInformation();

          //ここで保存名入力ダイアログ
          String titleName = title;
          print("titleName : " + titleName);
          final result =
              await DialogUtils.DeckSaveShowDialog(context, titleName);
          if (result == null) {
          } else {
            titleName = result;
            DeckObject deckObject = DeckObject();
            deckObject.insertOrUpdateDeckList(
                cardInDeckIdURI, titleName, "", 0);
            CardInDeckObject cardInDeckObject = CardInDeckObject();
            await cardInDeckObject.deleteCardInDeckList(cardInDeckIdURI);
            await cardInDeckObject.insertOrUpdateCardInDeckList(
                cardInDeckIdURI, cardInDeckList);
            setState(() {
              updateScreen();
            });
            DeckListViewRouter deckListViewRouter = DeckListViewRouter();
            deckListViewRouter.push(context);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       actions: <Widget>[
            //         TextButton(
            //           onPressed: () {},
            //           child: Text('保存しました'),
            //         ),
            //       ],
            //     );
            //   },
            // );
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.save), //Image.asset(saveIconURL),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
