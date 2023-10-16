import 'package:hive/hive.dart';
part '../register_data_model.g.dart';

@HiveType(typeId: 0)
class RegisterDataModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  DateTime? birthDate;
  @HiveField(2)
  String? experienceLevel;
  @HiveField(3)
  List<String> linguages = [];
  @HiveField(4)
  int? experienceTime;
  @HiveField(5)
  double? salary;

  RegisterDataModel();

  RegisterDataModel.empty() {
    name = "";
    birthDate = null;
    experienceLevel = "";
    linguages = [];
    salary = 0;
    experienceTime = 0;
  }
}
