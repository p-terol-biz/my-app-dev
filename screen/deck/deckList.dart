import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/Constant/constant.dart';
import 'package:myapp/Model/deckObject.dart';
import 'dart:async';

// class DeckProperty {
//   final String title;

//   final String deckTopImageURL;

//   final int numberOfCards;

//   final String cardInDeckId;

//   DeckProperty(
//       this.title, this.deckTopImageURL, this.numberOfCards, this.cardInDeckId);

//   factory DeckProperty.fromDeckJsonProperty(DeckJsonProperty deckJsonProperty) {
//     return DeckProperty(deckJsonProperty.title,
//         deckJsonProperty.deckTopImageURL, -1, deckJsonProperty.deckId);
//   }
// }

// class DeckJsonProperty {
//   final String deckId;

//   final String title;

//   final String deckTopImageURL;

//   DeckJsonProperty(this.deckId, this.title, this.deckTopImageURL);

//   factory DeckJsonProperty.fromDeckProperty(DeckProperty deckProperty) {
//     return DeckJsonProperty(deckProperty.title, deckProperty.cardInDeckId,
//         deckProperty.deckTopImageURL);
//   }
// }

// final models = [
//   // DeckProperty("Test001", "images/test001.jpg", 30),
//   // DeckProperty("Test002", "images/test001.jpg", 30),
//   // DeckProperty("Test003", "images/test001.jpg", 30),
//   // DeckProperty("Test004", "images/test001.jpg", 30),
//   // DeckProperty("Test005", "images/test001.jpg", 30),
//   // DeckProperty("Test006", "images/test001.jpg", 30),
//   // DeckProperty("Test007", "images/test001.jpg", 30),
//   // DeckProperty("Test008", "images/test001.jpg", 30),
//   // DeckProperty("Test009", "images/test001.jpg", 30),
//   // DeckProperty("Test010", "images/test001.jpg", 30),
//   // DeckProperty("Test011", "images/test001.jpg", 30),
//   // DeckProperty("Test012", "images/test001.jpg", 30),

//   // DeckProperty("Test001", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test002", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test003", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test004", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test005", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test006", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test007", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test008", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test009", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test010", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test011", "assets/images/test001.jpg", 30),
//   // DeckProperty("Test012", "assets/images/test001.jpg", 30),

//   DeckProperty("Test001", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test002", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test003", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test004", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test005", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test006", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test007", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test008", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test009", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test010", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test011", "assets/images/logo__tbb.png", 30, ""),
//   DeckProperty("Test012", "assets/images/logo__tbb.png", 30, ""),
// ];

// var models = [];

// Future<String> getDeckModels() async {
//   final IdRepository idRepository = IdRepository();
//   String deckModels = await idRepository.getId("deckModels");

//   print("getDeckModels.deckModels");
//   print(deckModels);

//   return deckModels;
// }

// Future<List<DeckJsonProperty>> StringTodeckModels(String jsonString) async {
//   print("jsonString>>");
//   print(jsonString);
//   List<DeckJsonProperty> resultList = [];
//   // List<dynamic> jsonList = jsonDecode(jsonString);
//   String cleanedJson = jsonString.replaceAll('[', '').replaceAll(']', '');
//   List<String> cleanedJsonList = cleanedJson.split('},');
//   cleanedJsonList.forEach((element) {
//     print("cleanedJsonList>>");
//     print(element);
//   });

//   print("cleanedJsonList>>");
//   print(cleanedJsonList);
//   for (String cleanedJson in cleanedJsonList) {
//     print("cleanedJson>>");
//     print(cleanedJson);
//     String trimmedObject = cleanedJson.replaceAll('{', '').replaceAll('}', '');
//     List<String> keyValuePairs = trimmedObject.split(',');
//     print("keyValuePairs>>>");
//     print(keyValuePairs.toString());
//     String deckId = "";
//     String title = "";
//     String deckTopImageURL = "";

//     for (String keyValuePair in keyValuePairs) {
//       List<String> parts = keyValuePair.trim().split(':');
//       String key = parts[0].replaceAll('"', '').trim();
//       String value = parts[1].replaceAll('"', '').trim();
//       print("key>>>");
//       print(key);
//       print("value>>>");
//       print(value);

//       switch (key) {
//         case "deckId":
//           deckId = value;
//           break;
//         case "title":
//           title = value;
//           break;
//         case "deckTopImageURL":
//           deckTopImageURL = value;
//           break;
//       }
//     }
//     print("deckId>>>");
//     print(deckId);
//     print("title>>>");
//     print(title);

//     DeckJsonProperty deckJsonProperty =
//         DeckJsonProperty(deckId, title, deckTopImageURL);

//     resultList.add(deckJsonProperty);
//   }
//   return resultList;
// }

// push(BuildContext context, String mode) {
//   // 画面 B へ進む
//   context.push('/deckDetail');
//   // Navigator.push(
//   //   context,
//   //   MaterialPageRoute(builder: (context) => DeckDetail(mode: mode)),
//   // );
// }

// Widget DeckItem(BuildContext context, DeckProperty model) {
//   // print("model");
//   // print(model);
//   // print("title");
//   // print(model.title);
//   // print("deckTopImageURL");
//   // print(model.deckTopImageURL);
//   final icon = Container(
//     margin: const EdgeInsets.all(1),
//     width: 100,
//     height: 100,
//     // 画像を丸くする
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(30.0),
//       child: Image.asset('${model.deckTopImageURL}'),
//     ),
//   );

//   final title = Container(
//     padding: const EdgeInsets.all(6),
//     height: 40,
//     alignment: Alignment.centerLeft,
//     child: Text(
//       '${model.title}',
//       style: const TextStyle(color: Colors.grey),
//     ),
//   );

//   return GestureDetector(
//       onTap: () => push(context, "editDeck"),
//       child: Container(
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           // 全体を青い枠線で囲む
//           border: Border.all(color: Colors.blue),
//           color: Colors.white,
//         ),
//         width: double.infinity,
//         // 高さ
//         height: 60,
//         child: Row(
//           children: [
//             icon,
//             Expanded(
//               child: Column(
//                 children: [title],
//               ),
//             ),
//           ],
//         ),
//       ));
// }

// class DeckListApp extends StatefulWidget {
//   @override
//   DeckList createState() => DeckList();
// }

// class DeckList extends State {
//   // const DeckList({super.key});

//   // Future<List<DeckJsonProperty>> getDeckModelsData() async {
//   //   // AAA の非同期関数を呼び出す
//   //   List<DeckJsonProperty> deckModelsData =
//   //       await StringTodeckModels(await getDeckModels());
//   //   return deckModelsData;
//   // }
//   List<DeckProperty> deckList = [];
//   @override
//   Future<void> asyncInitState() async {
//     Completer completerOfDeckList = Completer<String>();
//     DeckObject deckObject = DeckObject();
//     deckObject
//         .getDeckList()
//         .then((value) => {completerOfDeckList.complete(value)});
//     deckList = await completerOfDeckList.future;
//   }

//   void initState() {
//     super.initState();
//     asyncInitState();
//   }

//   Widget build(BuildContext context) {
//     final appBar =
//         AppBar(backgroundColor: Colors.purple, title: const Text('Deck List'));

//     return Scaffold(
//       appBar: appBar,
//       body: Container(
//           child: SizedBox(
//               //         child: FutureBuilder(
//               //   future: getDeckModelsData(),
//               //   builder: (context, snapshot) {
//               //     if (snapshot.connectionState == ConnectionState.waiting) {
//               //       // データ取得中の表示
//               //       return CircularProgressIndicator();
//               //     } else if (snapshot.hasError) {
//               //       // エラー発生時の表示
//               //       return Text("Error: ${snapshot.error}");
//               //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               //       // データがない場合の表示
//               //       return Text("No data available");
//               //     } else {
//               //       return ListView.builder(
//               //         // itemCount: models.length,
//               //         itemCount: snapshot.data!.length,
//               //         itemBuilder: ((context, index) {
//               //           print("deckModelsData");
//               //           print(snapshot.data);
//               //           // return DeckItem(context, models[index]);
//               //           return DeckItem(context,
//               //               DeckProperty.fromDeckJsonProperty(snapshot.data![index]));
//               //         }),
//               //       );
//               //     }
//               //   },
//               // )
//               child: ListView.builder(
//         itemCount: deckList.length,
//         itemBuilder: ((context, index) {
//           print("deckList");
//           print(deckList);
//           return DeckItem(context, deckList[index]);
//         }),
//       ))),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             push(context, "createDeck");
//           });
//         },
//         backgroundColor: Colors.black,
//         child: const Icon(Icons.add),
//       ),
//     );
//     // ListView.builder(
//     //     itemCount: models.length,
//     //     itemBuilder: (c, i) => DeckItem(c, models[i])))));
//   }
// }

// Widget DeckList() {
//   return Container(
//       child: SizedBox(
//           child: ListView.builder(
//               itemCount: models.length,
//               itemBuilder: (c, i) => DeckItem(c, models[i]))));
// }
