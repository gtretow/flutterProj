import 'package:hive/hive.dart';
import 'package:trilhaapp/model/model.dart';

class ConfigRepository {
  static late Box _box;
  //uso de await em classes no flutter
  //criar construtor vazio com meto statico

  static Future<ConfigRepository> load() async {
    if (Hive.isBoxOpen('config')) {
      _box = Hive.box('config');
    } else {
      _box = await Hive.openBox('config');
    }

    return ConfigRepository._load();
  }

  void save(ConfigModel configModel) {
    _box.put('conifgModel', {
      'username': configModel.username,
      'height': configModel.height,
      'receiveNotification': configModel.receiveNotification,
      'darkTheme': configModel.darkTheme
    });
  }

  ConfigModel getData() {
    var config = _box.get('configModel');

    if (config == null) {
      return ConfigModel.empty();
    } else {
      return ConfigModel(config['username'], config['height'],
          config['receiveNotification'], config['darkTheme']);
    }
  }

  ConfigRepository._load();
}
