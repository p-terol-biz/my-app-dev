import 'package:flutter/material.dart';

class DialogUtils {
  DialogUtils._();

  /// タイトルのみを表示するシンプルなダイアログを表示する
  static Future<String?> DeckSaveShowDialog(
    BuildContext context,
    String title,
  ) async {
    TextEditingController _controller = TextEditingController(text: title);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('タイトル'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "ここに入力"),
            ),
            // content: TextFormField(

            // ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                ),
                child: Text('キャンセル'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                ),
                child: Text('保存'),
                onPressed: () {
                  //OKを押したあとの処理
                  Navigator.of(context).pop(_controller.text);
                },
              ),
            ],
          );
        });

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text(title),
    //     );
    //   },
    // );
  }

  /// 入力した文字列を返すダイアログを表示する
  static Future<String?> showEditingDialog(
    BuildContext context,
    String text,
  ) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return TextEditingDialog(text: text);
      },
    );
  }
}

class TextEditingDialog extends StatefulWidget {
  const TextEditingDialog({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  State<TextEditingDialog> createState() => _TextEditingDialogState();
}

class _TextEditingDialogState extends State<TextEditingDialog> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TextFormFieldに初期値を代入する
    controller.text = widget.text ?? '';
    focusNode.addListener(
      () {
        // フォーカスが当たったときに文字列が選択された状態にする
        if (focusNode.hasFocus) {
          controller.selection = TextSelection(
              baseOffset: 0, extentOffset: controller.text.length);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 外側のタップでダイアログを閉じる
          Navigator.of(context).pop();
        },
        child: AlertDialog(
          content: TextFormField(
            autofocus: true, // ダイアログが開いたときに自動でフォーカスを当てる
            focusNode: focusNode,
            controller: controller,
            onFieldSubmitted: (_) {
              // エンターを押したときに実行される
              Navigator.of(context).pop(controller.text);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('完了'),
            )
          ],
        ));
  }
}
