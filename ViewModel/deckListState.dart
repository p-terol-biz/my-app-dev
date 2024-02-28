import 'package:flutter/material.dart';
import 'package:myapp/Model/deckObject.dart';
import 'package:myapp/View/deckItemWidget.dart';
import 'package:myapp/Router/router.dart';

import 'dart:async';

import '../Constant/constant.dart';

class DeckListApp extends StatefulWidget {
  const DeckListApp({Key? key}) : super(key: key);
  @override
  DeckList createState() => DeckList();
}

class DeckList extends State {
  List<DeckProperty> deckList = [];

  Future<List<DeckProperty>> getDeckList() async {
    // Completer completerOfDeckList = Completer<String>();
    DeckObject deckObject = DeckObject();
    return deckObject.getDeckList();
  }

  Future<void> updateScreen() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: const Text('デッキ一覧'),
    );

    DeckDetailViewRouter deckDetailViewRouter = DeckDetailViewRouter();

    return Scaffold(
      appBar: appBar,
      body: Container(
          child: SizedBox(
              child: FutureBuilder(
                  future: getDeckList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データ取得中の表示
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // エラー発生時の表示
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // データがない場合の表示
                      return Text("デッキがありません");
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          return DeckItem(
                              context, snapshot.data![index], updateScreen);
                        }),
                      );
                    }
                  }))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            deckDetailViewRouter
                .push(context, DeckType.CreateDeck, "", "", updateScreen, []);
          });
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
