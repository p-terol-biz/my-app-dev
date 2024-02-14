import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

final FirebaseStorage _storage = FirebaseStorage.instance;
final String _folderPath =
    'gs://zutomayocard-6280a.appspot.com'; // Storageバケットのルートフォルダ

Future<Image> _getFilesInFolder() async {
  Reference ref = _storage
      .ref()
      .child(_folderPath + '/Img/Card/1st/zutomayocard_1st_1.png');
  final String url = await ref.getDownloadURL();
  // final img = new Image(image: new CachedNetworkImageProvider(url));
  final img = Image(image: CachedNetworkImageProvider(url));

  return img;
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('List Files in Firebase Storage'),
      ),
      body: FutureBuilder<Image>(
        future: _getFilesInFolder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Image img = snapshot.data!;
            return Center(
              child: img,
            );
          }
        },
      ),
    ),
  );
}
