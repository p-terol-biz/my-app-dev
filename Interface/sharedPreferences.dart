import 'dart:html';
import 'package:myapp/Constant/constant.dart';

class IdRepository {
  final Storage _localStorage = window.localStorage;

  Future save(String key, String id) async {
    _localStorage[key] = id;
  }

  Future<String> getId(String key) async {
    return _localStorage[key] ?? ResultPropertyConstants.StatusError;
  }

  Future invalidate(String key) async {
    _localStorage.remove(key);
  }
}
