// Package imports:
import 'package:birdiefy/core/domain/local_data.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: LocalData)
class LocalDataImpl implements LocalData {
  final SharedPreferences _pref;
  LocalDataImpl(this._pref);

  @override
  bool? getBool(String key) => _pref.getBool(key);

  @override
  String? getString(String key) => _pref.getString(key);

  @override
  List<String>? getStringList(String key) => _pref.getStringList(key);

  @override
  Future<bool> setBool(String key, bool value) async =>
      await _pref.setBool(key, value);

  @override
  Future<bool> setString(String key, String value) async =>
      await _pref.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) async =>
      await _pref.setStringList(key, value);

  @override
  Future<bool> remove(String key) async => await _pref.remove(key);
}
