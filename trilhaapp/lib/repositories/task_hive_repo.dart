import 'package:hive/hive.dart';
import 'package:trilhaapp/model/task/task_model.dart';

class TaskHiveRepo {
  static late Box _box;

  TaskHiveRepo._create();

  static Future<TaskHiveRepo> load() async {
    if (Hive.isBoxOpen('taskDataModel')) {
      _box = Hive.box('taskDataModel');
    } else {
      _box = await Hive.openBox('taskDataModel');
    }

    return TaskHiveRepo._create();
  }

  save(TaskHiveModel taskHiveModel) {
    _box.add(taskHiveModel);
  }

  edit(TaskHiveModel taskHiveModel) {
    taskHiveModel.save();
  }

  delete(TaskHiveModel taskHiveModel) {
    taskHiveModel.delete();
  }

  List<TaskHiveModel> getData(bool notFinished) {
    if (notFinished) {
      return _box.values
          .cast<TaskHiveModel>()
          .where((el) => !el.finished)
          .toList();
    }
    return _box.values.cast<TaskHiveModel>().toList();
  }
}
