import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cahe_helper{
  static SharedPreferences? sharedpreferences;
  static init()async{
      sharedpreferences= await SharedPreferences.getInstance();
  }
  // دا لنوع واحد فقط
 static Future<bool> setbooldat ({@required String?key,@required bool?value})
 async{
  return await sharedpreferences!.setBool(key!, value!);
  }
  static bool? getbooldat({@required String?key}){
   return sharedpreferences!.getBool(key!);
  }

  // دا لكل الانواع

  static Future<bool> setdata ({@required String?key,@required dynamic value})
  async{
  if(value is bool)  return await sharedpreferences!.setBool(key!, value);
  if(value is String) return await sharedpreferences!.setString(key!, value);
  if(value is int)  return await sharedpreferences!.setInt(key!, value);
    return await sharedpreferences!.setDouble(key!, value);
  }
  static Future<bool> removedata({@required String?key})async{
   return await sharedpreferences!.remove(key!);
  }

  static dynamic? getdata({@required String?key}){
    return sharedpreferences!.get(key!);
  }
}