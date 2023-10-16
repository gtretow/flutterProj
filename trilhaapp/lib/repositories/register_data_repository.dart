import 'package:hive/hive.dart';
import 'package:trilhaapp/model/register/register_data_model.dart';

class RegisterDataRepo {
  static late Box _box;

  RegisterDataRepo._create();

  static Future<RegisterDataRepo> load() async {
    if (Hive.isBoxOpen('registerDataModel')) {
      _box = Hive.box('registerDataModel');
    } else {
      _box = await Hive.openBox('registerDataModel');
    }

    return RegisterDataRepo._create();
  }

  void save(RegisterDataModel configModel) {
    _box.put('registerDataModel', RegisterDataModel);
  }

  RegisterDataModel getData() {
    var registerDataModel = _box.get('RegisterDataModel');
    if (registerDataModel == null) {
      return RegisterDataModel.empty();
    }
    return registerDataModel;
  }
}
