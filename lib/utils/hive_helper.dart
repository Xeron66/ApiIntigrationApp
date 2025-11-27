import 'package:hive_flutter/hive_flutter.dart'; // Use hive_flutter

class HiveHelper {
  static const String _boxName = 'cacheBox';

  static Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return await Hive.openBox(_boxName);
  }

  static Future<void> save(String key, dynamic data) async {
    final box = await _getBox();
    await box.put(key, data);
  }

  static Future<dynamic> get(String key) async {
    final box = await _getBox();
    return box.get(key);
  }
}