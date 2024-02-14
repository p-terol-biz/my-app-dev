import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';

// Firebase FunctionsのエンドポイントURLを指定
const String firebaseFunctionsURL =
    'https://on-request-example-cspplpjlaq-uc.a.run.app';

// final imageStateProvider = StateProvider<Uint8List?>((ref) => null);

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String apiResponse = '';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text('Flutter Firebase Functions Example'),
//             ),
//             body: Center(
//               child: downloadPic(),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     downloadPic();
//               //   },
//               //   child: const Icon(Icons.download),
//               // ),
//             )));
//   }

//   void callFirebaseFunction() async {
//     try {
//       final headers = {'Content-Type': 'application/json'};
//       final body = jsonEncode({
//         'param1': 'value1',
//         'param2': 'value2',
//       });

//       final response = await http.post(Uri.parse(firebaseFunctionsURL),
//           headers: headers, body: body);

//       if (response.statusCode == 200) {
//         setState(() {
//           apiResponse = 'APIレスポンス： ${response.body}';
//         });
//       } else {
//         setState(() {
//           apiResponse = 'APIリクエストが失敗しました。ステータスコード： ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         apiResponse = 'APIリクエスト中にエラーが発生しました。 $e';
//       });
//     }
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// /// 画像のダウンロード
// Image? downloadPic() {
//   try {
//     /// 参照の作成
//     // String downloadName = 'image.png';
//     // final storageRef =
//     //     FirebaseStorage.instance.ref().child('users/$userID/$downloadName');

//     // final gsReference = FirebaseStorage.instance.refFromURL(
//     //     "gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png");

//     /// 画像をメモリに保存し、Uint8Listへ変換
//     // const oneMegabyte = 407 * 569;
//     // return await gsReference.getData(oneMegabyte);
//     // Image.network(
//     //     "gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png");

//     // final gsReference = FirebaseStorage.instance.refFromURL(
//     //     "gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png");
//     final Image img = new Image(
//         image: new CachedNetworkImageProvider(
//             "gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png"));

//     return img;
//   } catch (e) {
//     print(e);
//   }
// }

class MyApp extends StatelessWidget {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _imagePath =
      'gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png';

  Future<String> _getImageUrl() async {
    // 画像のダウンロードURLを取得
    final ref = _storage.ref().child(_imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Display Image from Firebase Storage'),
        ),
        body: FutureBuilder(
          future: _getImageUrl(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final imageUrl = snapshot.data as String?;
              if (imageUrl != null) {
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Text('Failed to load image'),
                );
              } else {
                return Text('Failed to load image');
              }
            }
          },
        ),
      ),
    );
  }
}
