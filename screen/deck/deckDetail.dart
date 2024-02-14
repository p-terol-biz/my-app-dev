import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screen/deck/deckModelsObject.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'dart:convert';

// final FirebaseStorage _storage = FirebaseStorage.instance;
// final String _imagePath =
//     'gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png';

// final String _imagePath = 'gs://zutomayocard-6280a.appspot.com/Img/Card/';

// final String _imagePath =
//     'gs://zutomayocard-6280a.appspot.com/Img/Test/Wanwan/test001.jpg';

// final String zutomayoCard1st = "1st/ZUTOMAYO_CARD_THE_BATTLE_BEGINS_1_";

// final String zutomayoCard2nd = "2nd/ZUTOMAYO_CARD_THE_BATTLE_BEGINS_2_";

// final String saveIconURL = "assets/images/SaveIcon.png";

// class CardProperty {
//   final String id;

//   final Future<String> cardImageURL;

//   CardProperty(this.id, this.cardImageURL);
// }

// class DeckProperty {
//   final String deckId;

//   final String title;

//   final Future<String> cardImageURL;

//   DeckProperty(this.deckId, this.title, this.cardImageURL);
// }

// class CardInDeckProperty {
//   final String cardInDeckId;

//   final String cardId;

//   final Future<String> cardImageURL;

//   CardInDeckProperty(this.cardInDeckId, this.cardId, this.cardImageURL);
// }

// class DeckJsonProperty {
//   final String deckId;

//   final String title;

//   DeckJsonProperty(this.deckId, this.title);

//   factory DeckJsonProperty.fromDeckProperty(DeckProperty deckProperty) {
//     return DeckJsonProperty(deckProperty.deckId, deckProperty.title);
//   }
// }

// class CardInDeckJsonProperty {
//   final String cardInDeckId;

//   final String cardId;

//   final Future<String> cardImageURL;

//   CardInDeckJsonProperty(this.cardInDeckId, this.cardId, this.cardImageURL);

//   factory CardInDeckJsonProperty.fromCardInDeckProperty(
//       CardInDeckProperty deckProperty) {
//     return CardInDeckJsonProperty(deckProperty.cardInDeckId,
//         deckProperty.cardId, deckProperty.cardImageURL);
//   }

//   // factory CardInDeckJsonProperty.fromJson(Map<String, dynamic> deckProperty) {
//   //   return CardInDeckJsonProperty(
//   //       deckProperty['cardInDeckId'], deckProperty['cardId']);
//   // }
// }

// final CardModels = new List.generate(
//     30,
//     (i) =>
//         CardProperty("Test" + i.toString().padLeft(3, '0'), _getImageUrl(i)));

// List<CardInDeckProperty> DeckModels = [];

// Future<List<CardInDeckJsonProperty>> getCardInDeckModelsData() async {
//   // AAA の非同期関数を呼び出す
//   List<CardInDeckJsonProperty> deckModelsData =
//       await StringToCardInDeckModels(await getCardInDeckModels());
//   return deckModelsData;
// }

// var deckModelsData = StringToCardInDeckModels(getCardInDeckModels().toString());

// String DeckModelsToString(List<DeckJsonProperty> deckModels) {
//   List<String> stringList = deckModels.map((deckProperty) {
//     // print('cardInDeckId ' + "${cardProperty.cardInDeckId}");
//     // print('cardId ' + "${cardProperty.cardId}");
//     // print('cardImageURL ' + "${cardProperty.cardImageURL}");

//     return '{"deckId": "${deckProperty.deckId}", "title": "${deckProperty.title}"}';
//     // return '{"cardInDeckId": "${cardProperty.cardInDeckId}", "cardId": "${cardProperty.cardId}", "cardImageURL": "${cardProperty.cardImageURL}"}';
//   }).toList();

//   // print('stringList' + stringList.toString());
//   return '[' + stringList.join(', ') + ']';
// }

// String cardInDeckModelsToString(List<CardInDeckJsonProperty> cardInDeckModels) {
//   List<String> stringList = cardInDeckModels.map((cardInDeckProperty) {
//     // print('cardInDeckId ' + "${cardProperty.cardInDeckId}");
//     // print('cardId ' + "${cardProperty.cardId}");
//     // print('cardImageURL ' + "${cardProperty.cardImageURL}");

//     return '{"cardInDeckId": "${cardInDeckProperty.cardInDeckId}", "cardId": "${cardInDeckProperty.cardId}"}';
//     // return '{"cardInDeckId": "${cardProperty.cardInDeckId}", "cardId": "${cardProperty.cardId}", "cardImageURL": "${cardProperty.cardImageURL}"}';
//   }).toList();

//   // print('stringList' + stringList.toString());
//   return '[' + stringList.join(', ') + ']';
// }

// Future<List<DeckJsonProperty>> StringToDeckModels(String jsonString) async {
//   List<DeckJsonProperty> resultList = [];
//   String cleanedJson = jsonString.replaceAll('[', '').replaceAll(']', '');
//   List<String> cleanedJsonList = cleanedJson.split('},');

//   for (String cleanedJson in cleanedJsonList) {
//     String trimmedObject = cleanedJson.replaceAll('{', '').replaceAll('}', '');
//     List<String> keyValuePairs = trimmedObject.split(',');
//     String deckId = "";
//     String title = "";
//     for (String keyValuePair in keyValuePairs) {
//       List<String> parts = keyValuePair.trim().split(':');
//       String key = parts[0].replaceAll('"', '').trim();
//       String value = parts[1].replaceAll('"', '').trim();

//       switch (key) {
//         case "deckId":
//           deckId = value;
//           break;
//         case "title":
//           title = value;
//           break;
//       }
//     }
//     DeckJsonProperty deckJsonProperty = DeckJsonProperty(deckId, title);

//     resultList.add(deckJsonProperty);
//   }
//   return resultList;
// }

// Future<List<CardInDeckJsonProperty>> StringToCardInDeckModels(
//     String jsonString) async {
//   // print("jsonString>>");
//   // print(jsonString);
//   List<CardInDeckJsonProperty> resultList = [];
//   // List<dynamic> jsonList = jsonDecode(jsonString);
//   String cleanedJson = jsonString.replaceAll('[', '').replaceAll(']', '');
//   List<String> cleanedJsonList = cleanedJson.split('},');
//   // cleanedJsonList.forEach((element) {
//   //   print("cleanedJsonList>>");
//   //   print(element);
//   // });

//   // print("cleanedJsonList>>");
//   // print(cleanedJsonList);
//   for (String cleanedJson in cleanedJsonList) {
//     // print("cleanedJson>>");
//     // print(cleanedJson);
//     String trimmedObject = cleanedJson.replaceAll('{', '').replaceAll('}', '');
//     List<String> keyValuePairs = trimmedObject.split(',');
//     // print("keyValuePairs>>>");
//     // print(keyValuePairs.toString());
//     String cardId = "";
//     String cardInDeckId = "";
//     String cardImageURL = "";

//     for (String keyValuePair in keyValuePairs) {
//       List<String> parts = keyValuePair.trim().split(':');
//       String key = parts[0].replaceAll('"', '').trim();
//       String value = parts[1].replaceAll('"', '').trim();
//       // print("key>>>");
//       // print(key);
//       // print("value>>>");
//       // print(value);

//       switch (key) {
//         case "cardId":
//           cardId = value;
//           break;
//         case "cardInDeckId":
//           cardInDeckId = value;
//           break;
//         case "cardImageURL":
//           cardImageURL = value;
//           break;
//       }
//     }
//     // print("cardId>>>");
//     // print(cardId);
//     // print("cardInDeckId>>>");
//     // print(cardInDeckId);

//     CardInDeckJsonProperty deckJsonProperty = CardInDeckJsonProperty(
//         cardInDeckId, cardId, Future.value(cardImageURL));

//     resultList.add(deckJsonProperty);
//   }
//   // List<CardInDeckJsonProperty> resultList =
//   //     jsonList.map((item) => CardInDeckJsonProperty.fromJson(item)).toList();
//   // print("deckModelsData>>");
//   // print(resultList);
//   return resultList;
// }

// Future<String> _getImageUrl(int cardNumber) async {
//   // 画像のダウンロードURLを取得
//   final ref = _storage
//       .ref()
//       .child(_imagePath + zutomayoCard1st + cardNumber.toString() + ".jpg");
//   final url = await ref.getDownloadURL();
//   return url;
// }

// Future<String> getDeckModels() async {
//   final IdRepository idRepository = IdRepository();
//   String deckModels = await idRepository.getId("deckModels");

//   return deckModels;
// }

// Future<String> getCardInDeckModels() async {
//   final IdRepository idRepository = IdRepository();
//   String deckModels = await idRepository.getId("CardInDeckModels");
//   // idRepository.getId("DeckModels").then((String value) {
//   //   deckModels = value;
//   // }).catchError((error) {
//   //   deckModels = "SSSSS";
//   // });
//   // String _deckModels = idRepository.getId("DeckModels");
//   print("getCardInDeckModels.deckModels");
//   print(deckModels);

//   return deckModels;
// }

// Future<List<CardInDeckProperty>> getCardInDeckList(String mode) async {
//   List<CardInDeckProperty> deckList = [];

//   if (mode == "createDeck") {
//     //何もしない
//   } else if (mode == "editDeck") {
//     List<CardInDeckJsonProperty> cardInDeckList =
//         await getCardInDeckModelsData();
//     cardInDeckList.forEach((element) {
//       CardInDeckProperty deckProperty = new CardInDeckProperty(
//           element.cardId, element.cardInDeckId, element.cardImageURL);
//       deckList.add(deckProperty);
//     });
//   }
//   return deckList;
// }
// Image? downloadPic(String? imageURL) {
//   try {
//     final Image img = new Image(
//         image: new CachedNetworkImageProvider(
//             imageURL));

//     return img;
//   } catch (e) {
//     print(e);
//   }

// class DialogUtils {
//   DialogUtils._();

//   /// タイトルのみを表示するシンプルなダイアログを表示する
//   static Future<void> showOnlyTitleDialog(
//     BuildContext context,
//     String title,
//   ) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//         );
//       },
//     );
//   }

//   /// 入力した文字列を返すダイアログを表示する
//   static Future<String?> showEditingDialog(
//     BuildContext context,
//     String text,
//   ) async {
//     return showDialog<String>(
//       context: context,
//       builder: (context) {
//         return TextEditingDialog(text: text);
//       },
//     );
//   }
// }

// class TextEditingDialog extends StatefulWidget {
//   const TextEditingDialog({Key? key, this.text}) : super(key: key);
//   final String? text;

//   @override
//   State<TextEditingDialog> createState() => _TextEditingDialogState();
// }

// class _TextEditingDialogState extends State<TextEditingDialog> {
//   final controller = TextEditingController();
//   final focusNode = FocusNode();
//   @override
//   void dispose() {
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // TextFormFieldに初期値を代入する
//     controller.text = widget.text ?? '';
//     focusNode.addListener(
//       () {
//         // フォーカスが当たったときに文字列が選択された状態にする
//         if (focusNode.hasFocus) {
//           controller.selection = TextSelection(
//               baseOffset: 0, extentOffset: controller.text.length);
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: TextFormField(
//         autofocus: true, // ダイアログが開いたときに自動でフォーカスを当てる
//         focusNode: focusNode,
//         controller: controller,
//         onFieldSubmitted: (_) {
//           // エンターを押したときに実行される
//           Navigator.of(context).pop(controller.text);
//         },
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop(controller.text);
//           },
//           child: const Text('完了'),
//         )
//       ],
//     );
//   }
// }

// Widget CardItem(BuildContext context, CardProperty model, String cardInDeckId,
//     String mode) {
//   return FutureBuilder(
//     future: model.cardImageURL,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Container();
//         //Text('Error: ${snapshot.error}');
//       } else {
//         final imageUrl = snapshot.data as String?;
//         if (imageUrl != null) {
//           return LongPressDraggable(
//             data: model,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: SizedBox(
//                 // height: 400.0,
//                 child: CachedNetworkImage(
//                   imageUrl: imageUrl,
//                   placeholder: (context, url) => CircularProgressIndicator(),
//                   errorWidget: (context, url, error) =>
//                       Text('Failed to load image 1'),
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             feedback: Container(
//               alignment: Alignment.centerLeft,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.5, // 画面サイズの70%
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 child: CachedNetworkImage(
//                   imageUrl: imageUrl,
//                   placeholder: (context, url) => CircularProgressIndicator(),
//                   errorWidget: (context, url, error) =>
//                       Text('Failed to load image 2'),
//                 ),
//               ),
//             ),
//             onDragEnd: (details) {
//               // ドラッグが完了したときの処理
//               DeckModels.add(CardInDeckProperty(
//                   model.id, cardInDeckId, model.cardImageURL));
//             },
//           );
//         } else {
//           return Text('Failed to load image 3');
//         }
//       }
//     },
//   );
// }

// Widget DeckCardItem(BuildContext context, CardInDeckProperty model,
//     Function deckModelsRemoveCard) {
//   return FutureBuilder(
//     future: model.cardImageURL,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Container();
//         //Text('Error: ${snapshot.error}');
//       } else {
//         final imageUrl = snapshot.data as String?;
//         if (imageUrl != null) {
//           return SizedBox(
//             // 画像の高さを指定
//             height: 400.0,
//             child: GestureDetector(
//               child: CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 placeholder: (context, url) => CircularProgressIndicator(),
//                 errorWidget: (context, url, error) =>
//                     Text('Failed to load image 4'),
//               ),
//               onTap: () {
//                 //deckmodelから削除
//                 deckModelsRemoveCard(model);
//               },
//             ),
//           );
//         } else {
//           return Text('Failed to load image 5');
//         }
//       }
//     },
//   );
// }

class DeckDetail extends StatefulWidget {
  final String mode;

  const DeckDetail({Key? key, required this.mode}) : super(key: key);

  push(BuildContext context) {
    // 画面 B へ進む
    context.push('/deckList');
  }

  @override
  _DeckDetailState createState() => _DeckDetailState(mode: mode);
}

class _DeckDetailState extends State<DeckDetail>
    with AutomaticKeepAliveClientMixin {
  final String mode;

  _DeckDetailState({required this.mode});

  void DeckModelsRemoveCard(model) {
    setState(() {
      int removeCardIndex =
          DeckModels.indexWhere((x) => x.cardInDeckId == model.cardInDeckId);
      DeckModels.removeAt(removeCardIndex);
    });
  }

  var cardInDeckIdURI = Uuid().v4().toString();

  // Future<void> someAsyncMethod() async {
  //   // AAA の非同期関数を呼び出す
  // }

  @override
  Future<void> setDeckList(String mode) async {
    List<CardInDeckProperty> deckList = await getCardInDeckList(mode);

    DeckModels.addAll(deckList);
    setState(() {});
  }

  void initState() {
    super.initState();
    setDeckList(mode);
  }

  Widget build(BuildContext context) {
    final appBar =
        AppBar(backgroundColor: Colors.purple, title: const Text('Card List'));

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
                        itemCount: CardModels.length,
                        itemBuilder: (c, i) => CardItem(
                            c, CardModels[i], cardInDeckIdURI, mode))))),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.grey,
            child: DragTarget(builder: (context, accepted, rejected) {
              return Container(
                  child: SizedBox(
                      child: FutureBuilder(
                          future: getCardInDeckList(mode),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // データ取得中の表示
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // エラー発生時の表示
                              return Text("Error: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              // データがない場合の表示
                              print("Errorr");
                              print(mode);
                              print(snapshot);
                              return Text("No data available");
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  addAutomaticKeepAlives: true,
                                  itemExtent: 100,
                                  itemBuilder: (c, i) => DeckCardItem(c,
                                      snapshot.data![i], DeckModelsRemoveCard));
                            }
                          })
                      // child: ListView.builder(
                      //     itemCount: DeckModels.length,
                      //     addAutomaticKeepAlives: true,
                      //     itemExtent: 100,
                      //     itemBuilder: (c, i) {
                      //       print("DeckCardItem >>>> ");
                      //       for (var item in DeckModels) {
                      //         print(item);
                      //       }
                      //       print(DeckModels);
                      //       DeckCardItem(
                      //           c, DeckModels[i], DeckModelsRemoveCard);
                      //     })
                      ));
            }, onAccept: (CardProperty data) {
              int dragInt = CardModels.indexWhere(
                  (x) => x.cardImageURL == data.cardImageURL);
              String cardInDeckId = cardInDeckIdURI;
              print(data.toString());
              print("onAccept >> $dragInt");
              print(CardModels.toString());
              CardInDeckProperty deckProperty = new CardInDeckProperty(
                  cardInDeckId,
                  CardModels[dragInt].id,
                  CardModels[dragInt].cardImageURL);
              DeckModels.add(deckProperty);
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
          String titleName = "";

          final result =
              await DialogUtils.showEditingDialog(context, titleName);
          setState(() {
            titleName = result ?? titleName;
          });

          //CardInDeck修正する場合
          // List<CardInDeckJsonProperty> deckModelsData =
          //     await StringToCardInDeckModels(await getCardInDeckModels());

          //CardInDeck新規保存
          List<CardInDeckJsonProperty> cardInDeckModelsData = [];

          //Deck 追加
          List<DeckJsonProperty> deckModelsData =
              await StringToDeckModels(await getDeckModels());

          print("cardInDeckModelsData");
          print(cardInDeckModelsData);

          DeckModels.forEach((element) {
            cardInDeckModelsData
                .add(CardInDeckJsonProperty.fromCardInDeckProperty(element));
          });

          deckModelsData.add(DeckJsonProperty(cardInDeckIdURI, titleName));

          String cardInDeckModelsString = cardInDeckModelsToString(
              cardInDeckModelsData.cast<CardInDeckJsonProperty>());

          String deckModelsString =
              DeckModelsToString(deckModelsData.cast<DeckJsonProperty>());

          print("cardInDeckModelsString");
          print(cardInDeckModelsString);

          final IdRepository idRepository = IdRepository();
          final String IdRepositoryKeyCardInDeckModels = 'cardInDeckModels';
          final String IdRepositoryKeyDeckModels = 'deckModels';

          idRepository.save(
              IdRepositoryKeyCardInDeckModels, cardInDeckModelsString);

          idRepository.save(IdRepositoryKeyDeckModels, deckModelsString);

          // String deckModelsString =
          //     '[{"deckId":"$cardInDeckIdURI", "title":"TestDeck"}]';

          // final String IdRepositoryKeyDeckModels = 'deckModels';
          // idRepository.save(IdRepositoryKeyDeckModels, deckModelsString);

          // String? strValue = await idRepository.getId('DeckModels');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                //LocalStorageに保存

                title: Text('保存しました!'),
                // content: Text(
                //   allRows[0].deckId +
                //       allRows[0].cardInDeckId +
                //       allRows[0].cardId,
                // ),
                // content: Text(deckModelsString),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.save), //Image.asset(saveIconURL),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Widget DeckDetail() {
//   return Container(
//       child: SizedBox(
//           child: ListView.builder(
//               itemCount: models.length,
//               itemBuilder: (c, i) => CardItem(c, models[i]))));
// }
