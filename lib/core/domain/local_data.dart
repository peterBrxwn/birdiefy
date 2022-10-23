abstract class LocalData {
  bool? getBool(String key);
  String? getString(String key);
  List<String>? getStringList(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> value);
  Future<bool> remove(String key);
}
