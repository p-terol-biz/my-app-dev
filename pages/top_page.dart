import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  TopPage({this.storage});
  final FirebaseStorage storage;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Image _image;

  Future<void> _downloadFile(String imgPath) async {
    // download path
    StorageReference ref = widget.storage.ref().child('images/$imgPath');
    final String url = await ref.getDownloadURL();
    final img = new Image(image: new CachedNetworkImageProvider(url));

    setState(() {
      _image = img;
    });

    final String name = await ref.getName();
    final String bucket = await ref.getBucket();
    final String path = await ref.getPath();
    print(
      'Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
      'at path: $path',
    );
  }

  @override
  Widget build(BuildContext context) {
    _downloadFile(
        'gs://zutomayocard-6280a.appspot.com/Img/Card/1st/zutomayocard_1st_1.png');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter Storage Example'),
      ),
      body: Center(
        child: Row(
          children: [
            _image,
          ],
        ),
      ),
    );
  }
}
