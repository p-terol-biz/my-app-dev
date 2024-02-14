import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/env/env.dart';
import 'package:myapp/screen/top.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:io';
// import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseOptions firebaseOptions = FirebaseOptions(
  //   apiKey: 'AIzaSyAPRY2EJMJHD7O_LLnoDBfOH__QgmedHVs',
  //   appId: '1:871790315949:web:76b59ac25d8906db6db924',
  //   messagingSenderId: '871790315949',
  //   projectId: 'zutomayocard-6280a',
  //   storageBucket: 'zutomayocard-6280a.appspot.com',
  // );
  // await Firebase.initializeApp(options: firebaseOptions);
  FirebaseOptions firebaseOptions = AppSetting();
  Firebase.initializeApp(options: firebaseOptions);
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfiWeb;
  // databaseFactoryFfi;
  // final list = ListView.builder(
  //   itemCount: models.length,
  //   itemBuilder: (c, i) => DeckList(models[i]),
  // );

  // runApp(MyApp());
  runApp(MyApp());
}

// class DeckProperty {
//   final String title;

//   final String deckTopImageURL;

//   final int numberOfCards;

//   DeckProperty(this.title, this.deckTopImageURL, this.numberOfCards);
// }

// final models = [
//   DeckProperty("Test001", "images/logo__tbb.png", 30),
//   DeckProperty("Test002", "images/logo__tbb.png", 30),
//   DeckProperty("Test003", "images/logo__tbb.png", 30),
//   DeckProperty("Test004", "images/logo__tbb.png", 30),
//   DeckProperty("Test005", "images/logo__tbb.png", 30),
//   DeckProperty("Test006", "images/logo__tbb.png", 30),
//   DeckProperty("Test007", "images/logo__tbb.png", 30),
//   DeckProperty("Test008", "images/logo__tbb.png", 30),
//   DeckProperty("Test009", "images/logo__tbb.png", 30),
//   DeckProperty("Test010", "images/logo__tbb.png", 30),
//   DeckProperty("Test011", "images/logo__tbb.png", 30),
//   DeckProperty("Test012", "images/logo__tbb.png", 30),
// ];

// Widget DeckList(DeckProperty model) {
//   final icon = Container(
//     margin: const EdgeInsets.all(20),
//     width: 60,
//     height: 60,
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

//   return Container(
//     padding: const EdgeInsets.all(1),
//     decoration: BoxDecoration(
//       // 全体を青い枠線で囲む
//       border: Border.all(color: Colors.blue),
//       color: Colors.white,
//     ),
//     width: double.infinity,
//     // 高さ
//     height: 60,
//     child: Row(
//       children: [
//         icon,
//         Expanded(
//           child: Column(
//             children: [title],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text('Zutomayo Card'),
//             ),
//             backgroundColor: Colors.grey,
//             body: Container(
//                 child: SizedBox(
//                     height: 400,
//                     child: ListView.builder(
//                         itemCount: models.length,
//                         itemBuilder: (c, i) => DeckList(models[i]))))));
//   }

  // return _getFilesInFolder();

  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // final String _folderPath =
  //     'gs://zutomayocard-6280a.appspot.com'; // Storageバケットのルートフォルダ

  // Future<Image> _getFilesInFolder() async {
  //   Reference ref = _storage
  //       .ref()
  //       .child(_folderPath + '/Img/Card/1st/zutomayocard_1st_1.png');
  //   final String url = await ref.getDownloadURL();
  //   // final img = new Image(image: new CachedNetworkImageProvider(url));
  //   final img = Image(image: CachedNetworkImageProvider(url));

  //   return img;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text('List Files in Firebase Storage'),
  //       ),
  //       body: FutureBuilder<Image>(
  //         future: _getFilesInFolder(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return CircularProgressIndicator();
  //           } else if (snapshot.hasError) {
  //             return Text('Error: ${snapshot.error}');
  //           } else {
  //             Image img = snapshot.data!;
  //             return Center(
  //               child: img,
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }
// }
