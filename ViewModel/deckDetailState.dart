import 'package:flutter/material.dart';
import 'package:zutomayoddeck/Model/deckObject.dart';
import 'package:zutomayoddeck/View/cardItemWidget.dart';
import 'package:zutomayoddeck/View/cardInDeckItemWidget.dart';
import 'package:zutomayoddeck/Model/cardInDeckObject.dart';
import 'package:zutomayoddeck/Model/cardObject.dart';
import 'package:zutomayoddeck/Component/dialogComponent.dart';
import 'package:zutomayoddeck/Router/router.dart';
import 'package:zutomayoddeck/ViewModel/deckListState.dart';

import 'dart:async';
import 'package:uuid/uuid.dart';

import '../Constant/constant.dart';
import 'cardSearchFormState.dart';

class DeckDetail extends StatefulWidget {
  final String mode;
  final String deckId;
  final String title;
  final Function updateScreen;
  final List<String> cardIdList;

  const DeckDetail(
      {Key? key,
      required this.mode,
      required this.deckId,
      required this.title,
      required this.updateScreen,
      required this.cardIdList})
      : super(key: key);

  // push(BuildContext context) {
  //   // 画面 B へ進む
  //   DeckDetailViewRouter deckDetailViewRouter = DeckDetailViewRouter();
  //   deckDetailViewRouter.push(context, "createDeck", updateScreen);
  // }

  @override
  _DeckDetailState createState() => _DeckDetailState(
      mode: mode,
      deckId: deckId,
      title: title,
      updateScreen: updateScreen,
      cardIdList: cardIdList);
}

class _DeckDetailState extends State<DeckDetail>
    with AutomaticKeepAliveClientMixin {
  final String mode;
  final String deckId;
  final String title;
  final Function updateScreen;
  final List<String> cardIdList;

  _DeckDetailState(
      {required this.mode,
      required this.deckId,
      required this.title,
      required this.updateScreen,
      required this.cardIdList});

  List<CardInDeckProperty> cardInDeckList = [];
  List<CardProperty> cardList = [];
  List<String> notAllowedInDeckList = [];
  Widget? searchResultsWidget = null;
  var cardInDeckIdURI = "";
  Map<String, bool> cardItemLoadingBoolList = {};
  bool IsActiveScreenLoading = false;
  Map<String, Image> cardItemImageList = {};
  int imageMaxLoadingCount = 10;

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
      for (var element in cardInDeckList) {
        setNotAllowedInDeckList(cardInDeckList, element.cardId);
      }
    }
  }

  Future<void> setCardList() async {
    CardObject cardObject = CardObject();
    cardList = await cardObject.getCardList(cardIdList);
    cardItemLoadingBoolList = Map.fromIterable(
        List.generate(cardList.length, (index) => index.toString()),
        key: (key) => cardList[key].id,
        value: (value) => false);
  }

  Future<void> setCardAndCardInDeckList() async {
    await setCardInDeckList();
    await setCardList();
    await setCardItemImageList();

    if (mode == DeckType.CreateDeck) {
      cardInDeckIdURI = Uuid().v4().toString();
    } else if (mode == DeckType.EditDeck) {
      cardInDeckIdURI = deckId;
    }

    if (cardList.length == cardItemImageList.length) {
      IsActiveScreenLoading = false;
    }
    setState(() {});
  }

  Future<Image> getCardItemImage(String imageURL) async {
    final Completer<Image> completer = Completer();
    final image = Image.network(imageURL);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          completer.complete(image); // Completerに画像を渡す
        },
      ),
    );
    return completer.future;
  }

  Future<Map<String, Image>> convertFutureImageMap(
      Map<String, Future<Image>> futureImageMap) async {
    Map<String, Image> imageMap = {};

    await Future.forEach(futureImageMap.entries,
        (MapEntry<String, Future<Image>> entry) async {
      final String key = entry.key;
      final Future<Image> futureImage = entry.value;
      final Image image = await futureImage; // Future<Image>を待機してImageに変換

      imageMap[key] = image; // 新しいMapにImageを追加
    });

    return imageMap;
  }

  Future<void> setCardItemImageList() async {
    Map<String, Future<Image>> _cardItemImageList = {};
    await Future.forEach(cardList, (element) async {
      _cardItemImageList[element.id] = getCardItemImage(element.cardImageURL);
    });
    cardItemImageList.addAll(await convertFutureImageMap(_cardItemImageList));
  }

  @override
  void initState() {
    super.initState();
    IsActiveScreenLoading = true;
    setCardAndCardInDeckList();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print("In build ");
    var appBar;
    if (mode == DeckType.CreateDeck) {
      appBar = AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              DeckListViewRouter deckListViewRouter = DeckListViewRouter();
              deckListViewRouter.push(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.purple,
        title: const Text('デッキ作成'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    mode: mode,
                    deckId: deckId,
                    title: title,
                    updateScreen: updateScreen),
              );
            },
          ),
        ],
      );
    } else if (mode == DeckType.EditDeck) {
      appBar = AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              DeckListViewRouter deckListViewRouter = DeckListViewRouter();
              deckListViewRouter.push(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.purple,
        title: const Text('デッキ編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    mode: mode,
                    deckId: deckId,
                    title: title,
                    updateScreen: updateScreen),
              );

              // if (searchResults != null) {
              //   updateListWithSearchResults(searchResults);
              // }
            },
          ),
        ],
      );
    }
    return Stack(children: [
      Scaffold(
        appBar: appBar,
        body: Row(
          children: <Widget>[
            Expanded(
                flex: 6,
                child: SizedBox(
                  child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.all(10),
                      itemCount: cardList.length,
                      itemBuilder: (c, i) => CardItem(
                          c,
                          cardList[i],
                          notAllowedInDeckList,
                          cardInDeckIdURI,
                          mode,
                          cardItemImageList[cardList[i].id])),
                )),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey,
                child: DragTarget(builder: (context, accepted, rejected) {
                  return SizedBox(child: Builder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                          itemCount: cardInDeckList.length,
                          addAutomaticKeepAlives: true,
                          itemExtent: 100,
                          itemBuilder: (c, i) => CardInDeckItem(
                              c, cardInDeckList[i], removeCardInDeckList));
                    },
                  ));
                }, onAccept: (CardProperty data) {
                  addCardInDeckList(
                      cardInDeckIdURI, data.id, data.cardImageURL);
                }),
              ),
            )
          ],
        ),
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
            }
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.save), //Image.asset(saveIconURL),
        ),
      ),
      IsActiveScreenLoading
          ? Container(
              color: Colors.purple, // 背景色を紫色に設定
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container()
    ]);
  }

  @override
  bool get wantKeepAlive => true;

  // Widget cardItemListWidget() {
  //   List<CardProperty> _cardList = [];

  //   if (cardIdList.isNotEmpty) {
  //     // cardIdListに何かあったら
  //     cardList.forEach((element) {
  //       if (cardIdList.contains(element.id)) {
  //         _cardList.add(element);
  //       }
  //     });
  //   } else {
  //     _cardList.addAll(cardList);
  //   }
  //   return ListView.builder(
  //       addAutomaticKeepAlives: true,
  //       padding: EdgeInsets.all(10),
  //       itemCount: cardList.length,
  //       itemBuilder: (c, i) => CardItem(
  //           c, _cardList[i], notAllowedInDeckList, cardInDeckIdURI, mode));
  // }
}
