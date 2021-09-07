import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFunctions{

  static String userLoggedInSharedPreference = "ISLOGGEDIN";
  static String userNameSharedPreference = "UserNameKey";
  static String userEmailInSharedPreference = "UserEmailKey";

  //adding values to sharedPreference
  // static Future<bool> userLoggedIn(bool isLoggedIn) async {
  //   SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
  //   return await prefs.setBool(userLoggedInSharedPreference, isLoggedIn);
  // }
  static userLoggedIn(bool isLoggedIn) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.setBool(userLoggedInSharedPreference, isLoggedIn);
    return res;
  }
  static saveUserName(String userName) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.setString(userNameSharedPreference, userName);
    return res;
  }
  static saveUserEmail(String userEmail) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.setString(userEmailInSharedPreference, userEmail);
    return res;
  }

  //getting value from sharedPreference
  // static Future<bool?> getUserLoggedIn() async {
  //   SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
  //   return prefs.getBool(userLoggedInSharedPreference);
  // }
  static getUserLoggedIn() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.getBool(userLoggedInSharedPreference);
    return res;
  }
  // static Future<String?> getUserName() async {
  //   SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
  //   return prefs.getString(userNameSharedPreference);
  // }
  static getUserName() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.getString(userNameSharedPreference);
    return res;
  }
  // static Future<String?> getUserEmail() async {
  //   SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
  //   return prefs.getString(userEmailInSharedPreference);
  // }
  static getUserEmail() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var res = prefs.getString(userEmailInSharedPreference);
    return res;
  }

}