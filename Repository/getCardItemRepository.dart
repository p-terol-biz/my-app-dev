import 'package:zutomayoddeck/Interface/getDownloadURL.dart';
import 'package:zutomayoddeck/Constant/constant.dart';
import 'dart:async';

class GetCardItemRepository {
  Future<String> getImagePathUrl(String imagePath) async {
    String url;
    try {
      GetURL getURL = GetURL();
      url = await getURL.getDownloadURL(imagePath);
    } catch (e) {
      url = ResultPropertyConstants.StatusError;
    }
    return url;
  }
}
