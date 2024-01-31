import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? prefs;
  SharedPrefs() {
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> _sharedPrefsGetString(
      {required String key, String type = "read", String data = ""}) async {
    if (prefs == null) {
      await init();
    }
    String value = "";
    if (type == "write") {
      prefs!.setString(key, data);
    } else if (type == "remove") {
      prefs!.remove(key);
    } else if (type == "read") {
      value = prefs!.getString(key) ?? "";
    }
    return value;
  }

  Future<String> sharedPrefsLoginToken(
      {String type = "read", String data = ""}) async {
    String key = "sellerToken";
    return _sharedPrefsGetString(key: key, type: type, data: data);
  }

  Future<String> sharedPrefsSellerID(
      {String type = "read", String data = ""}) async {
    String key = "sellerID";
    return _sharedPrefsGetString(key: key, type: type, data: data);
  }

  Future<String> sharedPrefsSellerObject(
      {String type = "read", String data = ""}) async {
    String key = "sellerData";
    return _sharedPrefsGetString(key: key, type: type, data: data);
  }

  clear() async {
    // ignore: unnecessary_null_comparison
    if (prefs == null) {
      await init();
    }
    await prefs!.clear();
  }
}
