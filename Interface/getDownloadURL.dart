import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/Constant/constant.dart';

class GetURL {
  Future<String> getDownloadURL(String path) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;

    String url;
    try {
      final ref = _storage.ref().child(path);
      url = await ref.getDownloadURL();
    } catch (e) {
      url = ResultPropertyConstants.StatusError;
    }
    return url;
  }
}
