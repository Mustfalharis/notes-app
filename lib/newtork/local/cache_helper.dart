import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper
{
  static SharedPreferences? sharedPreferences;
  static init() async
  {
    sharedPreferences= await SharedPreferences.getInstance();
  }
  static void clear()=> sharedPreferences!.clear();
  static Future<bool> putBoolean({required bool value ,  required String? key  }) async
  {
    return await sharedPreferences!.setBool(key.toString(), value);
  }
  static dynamic getBoolean({required String key})
  {
    return  sharedPreferences!.get(key);
  }

  static Future<bool>?saveData({String? key, dynamic? value,})async
  {
    if(value is String) return await sharedPreferences!.setString(key.toString(), value);
    if(value is int) return await sharedPreferences!.setInt(key.toString(), value);
    if(value is bool) return await sharedPreferences!.setBool(key.toString(), value);
    return await sharedPreferences!.setDouble(key.toString(), value);
  }

  static Future<bool> removeData({required String key})
  async{
    print(key);
    return await sharedPreferences!.remove(key.toString());
  }

}

