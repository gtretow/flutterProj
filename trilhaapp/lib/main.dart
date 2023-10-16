import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/register/register_data_model.dart';
import 'package:trilhaapp/model/task/task_model.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(documentDirectory.path);
  Hive.registerAdapter(RegisterDataModelAdapter());
  Hive.registerAdapter(TaskHiveModelAdapter());
  runApp(const MyApp());
}
