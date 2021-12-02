import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }
  static void saveBoolean(String key,bool value)async{
    await sharedPreferences.setBool(key, value);
  }
}
