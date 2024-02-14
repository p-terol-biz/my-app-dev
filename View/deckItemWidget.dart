import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/Model/deckObject.dart';
import 'package:myapp/Router/router.dart';
import '../Constant/constant.dart';

Widget DeckItem(
    BuildContext context, DeckProperty model, Function updateScreen) {
  final icon = Container(
    margin: const EdgeInsets.all(1),
    width: 100,
    height: 100,
    // 画像を丸くする
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.asset('${model.deckTopImageURL}'),
    ),
  );

  final title = Container(
    padding: const EdgeInsets.all(6),
    height: 40,
    alignment: Alignment.centerLeft,
    child: Text(
      '${model.title}',
      style: const TextStyle(color: Colors.grey),
    ),
  );

  final menu = Container(
    padding: const EdgeInsets.all(6),
    child: IconButton(
      icon: Icon(Icons.more_vert),
      iconSize: 20,
      onPressed: () {
        //下から選択肢が表示される（アイコン＋機能）
        //デッキ名の編集
        //デッキの削除
        showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => Material(
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: const Text('デッキ名の編集'),
                          leading: const Icon(Icons.edit),
                          onTap: () {
                            // 選択したデッキID、デッキ名を取得
                            // デッキ名の入力
                            // デッキ名のみDB
                          },
                        ),
                        ListTile(
                          title: const Text('デッキの削除'),
                          leading: const Icon(Icons.delete),
                          onTap: () {
                            // 選択したデッキIDを取得
                            // 確認ダイアログの表示
                            // デッキDBから対象IDを削除
                          },
                        ),
                      ],
                    ),
                  ),
                ));
      },
    ),
  );

  DeckDetailViewRouter deckDetailViewRouter = DeckDetailViewRouter();

  return GestureDetector(
      onTap: () => deckDetailViewRouter.push(
          context, DeckType.EditDeck, model.deckId, model.title, updateScreen),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          // 全体を青い枠線で囲む
          border: Border.all(color: Colors.blue),
          color: Colors.white,
        ),
        width: double.infinity,
        // 高さ
        height: 60,
        child: Row(
          children: [
            icon,
            Expanded(
              child: Column(
                children: [title],
              ),
            ),
            menu
          ],
        ),
      ));
}
