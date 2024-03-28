import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:zutomayoddeck/Model/cardObject.dart';

Widget CardItem(
    BuildContext context,
    CardProperty model,
    List<String> notAllowedInDeckList,
    String cardInDeckId,
    String mode,
    Image? cardItemImage) {
  return Builder(builder: (BuildContext context) {
    if (notAllowedInDeckList.contains(model.id)) {
      return Container(
        child: Container(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            // child: Image.network(
            //   model.cardImageURL,
            //   loadingBuilder: (BuildContext context, Widget child,
            //       ImageChunkEvent? loadingProgress) {
            //     if (loadingProgress == null) {
            //       // 画像が読み込まれた場合
            //       setCardItemLoadingBool(model.id);
            //       return child;
            //     } else {
            //       // 画像の読み込み中の場合
            //       return CircularProgressIndicator(); // ローディングインジケーターを表示
            //     }
            //   },
            //   color: Colors.grey, // グレースケールにする色
            //   colorBlendMode: BlendMode.saturation,
            // ),
            child: cardItemImage.isNull
                ? SizedBox()
                : Image(
                    image: cardItemImage!.image,
                    color: Colors.grey, // グレースケールにする色
                    colorBlendMode: BlendMode.saturation,
                  ),
          ),
        ),
      );
    } else {
      return Container(
          child: LongPressDraggable(
        data: model,
        child: Container(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            // height: 400.0,
            // child: Image.network(
            //   model.cardImageURL,
            //   fit: BoxFit.contain,
            // ),
            child: cardItemImage.isNull
                ? SizedBox()
                : Image(
                    image: cardItemImage!.image,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        feedback: Container(
          alignment: Alignment.centerLeft,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5, // 画面サイズの70%
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(model.cardImageURL, fit: BoxFit.contain)),
        ),
        delay: Duration(milliseconds: 200),
      ));
    }
  });
}
