// ignore_for_file: unnecessary_getters_setters

class ConfigModel {
  String _username = '';
  double _height = 0;
  bool _receiveNotification = false;
  bool _darkTheme = false;

  ConfigModel.empty() {
    _username = "";
    _height = 0;
    _receiveNotification = false;
    _darkTheme = false;
  }

  ConfigModel(
      this._username, this._height, this._receiveNotification, this._darkTheme);

  String get username => _username;
  set username(String value) {
    _username = value;
  }

  double get height => _height;
  set height(double value) {
    _height = value;
  }

  bool get receiveNotification => _receiveNotification;
  set receiveNotification(bool value) {
    _receiveNotification = value;
  }

  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
  }
}
