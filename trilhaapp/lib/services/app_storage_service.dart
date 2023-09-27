// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  KEY_DATA_NAME,
  KEY_DATA_BIRTHDATE,
  KEY_DATA_LEVEL_EXPERIENCE,
  KEY_DATA_LANGUAGES,
  KEY_DATA_EXPERIENCE_TIME,
  KEY_DATA_SALARY,
  KEY_DATA_USER,
  KEY_DATA_HEIGHT,
  KEY_DATA_RECEIVE_NOTIFICATION,
  KEY_DATA_DARK_THEME,
}

class AppStorageService {
  Future<void> setConfigDarkTheme(bool value) async {
    await _setBool(STORAGE_CHAVES.KEY_DATA_DARK_THEME.toString(), value);
  }

  Future<bool> getConfigDarkTheme() async {
    return _getBool(STORAGE_CHAVES.KEY_DATA_DARK_THEME.toString());
  }

  Future<void> setConfigReceiveNotification(bool value) async {
    await _setBool(
        STORAGE_CHAVES.KEY_DATA_RECEIVE_NOTIFICATION.toString(), value);
  }

  Future<bool> getConfigReceiveNotification() async {
    return _getBool(STORAGE_CHAVES.KEY_DATA_RECEIVE_NOTIFICATION.toString());
  }

  Future<void> setConfigHeight(double value) async {
    await _setDouble(STORAGE_CHAVES.KEY_DATA_HEIGHT.toString(), value);
  }

  Future<double> getConfigHeight() async {
    return _getDouble(STORAGE_CHAVES.KEY_DATA_HEIGHT.toString());
  }

  Future<void> setConfigUsername(String nome) async {
    await _setString(STORAGE_CHAVES.KEY_DATA_NAME.toString(), nome);
  }

  Future<String> getConfigUsername() async {
    return _getString(STORAGE_CHAVES.KEY_DATA_NAME.toString());
  }

  Future<void> setRegistrationDataName(String nome) async {
    await _setString(STORAGE_CHAVES.KEY_DATA_NAME.toString(), nome);
  }

  Future<String> getRegistrationDataName() async {
    return _getString(STORAGE_CHAVES.KEY_DATA_NAME.toString());
  }

  Future<void> setRegistrationBirthDate(DateTime data) async {
    await _setString(
        STORAGE_CHAVES.KEY_DATA_BIRTHDATE.toString(), data.toString());
  }

  Future<String> getRegistrationBirthDate() async {
    return _getString(STORAGE_CHAVES.KEY_DATA_BIRTHDATE.toString());
  }

  Future<void> setRegistrationExperienceLevel(String value) async {
    await _setString(
        STORAGE_CHAVES.KEY_DATA_LEVEL_EXPERIENCE.toString(), value);
  }

  Future<String> getRegistrationExperienceLevel() async {
    return _getString(STORAGE_CHAVES.KEY_DATA_LEVEL_EXPERIENCE.toString());
  }

  Future<void> setRegistrationLanguages(List<String> values) async {
    await _setStringList(STORAGE_CHAVES.KEY_DATA_LANGUAGES.toString(), values);
  }

  Future<List<String>> getRegistrationLanguages() async {
    return _getStringList(STORAGE_CHAVES.KEY_DATA_LANGUAGES.toString());
  }

  Future<void> setRegistrationExperienceTime(int value) async {
    await _setInt(STORAGE_CHAVES.KEY_DATA_EXPERIENCE_TIME.toString(), value);
  }

  Future<int> getRegistrationExperienceTime() async {
    return _getInt(STORAGE_CHAVES.KEY_DATA_EXPERIENCE_TIME.toString());
  }

  Future<void> setRegistrationSalary(double value) async {
    await _setDouble(STORAGE_CHAVES.KEY_DATA_SALARY.toString(), value);
  }

  Future<double> getRegistrationSalary() async {
    return _getDouble(STORAGE_CHAVES.KEY_DATA_SALARY.toString());
  }

  Future<void> _setBool(String key, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(key, value);
  }

  Future<bool> _getBool(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(key) ?? false;
  }

  Future<void> _setString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  Future<String> _getString(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  Future<void> _setInt(String key, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(key, value);
  }

  Future<int> _getInt(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(key) ?? 0;
  }

  Future<void> _setDouble(String key, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(key, value);
  }

  Future<double> _getDouble(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key) ?? 0;
  }

  Future<void> _setStringList(String key, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(key, values);
  }

  Future<List<String>> _getStringList(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(key) ?? [];
  }
}
