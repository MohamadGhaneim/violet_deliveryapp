import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/model/delivery.dart';

class PrefHelper {
  static const _userKey = 'delivery_user';

  static Future<bool> isloggedin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isloggedin") ?? false;
  }

  static Future<void> setloggedin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isloggedin", true);
  }

  /// SAVE
  static Future<void> saveDelivery(Delivery delivery) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(delivery.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  // update delivery
  static Future<void> updateDelivery(Delivery delivery) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(delivery.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  /// GET
  static Future<Delivery> getDelivery() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString == null) {
      throw Exception("Error : SharedPreferences  getDelivery");
    }
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Delivery.fromJson({'data': json});
  }

  /// CLEAR
  static Future<void> clearDelivery() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove("isloggedin");
  }
}
