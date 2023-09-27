import 'package:hive/hive.dart';

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
}
