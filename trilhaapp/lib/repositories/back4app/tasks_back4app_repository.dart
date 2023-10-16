import 'package:trilhaapp/model/task/tasks_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4app_custom.repository.dart';

class TasksBack4AppRepository {
  final _customDio = Back4AppCustomDio();

  TasksBack4AppRepository();

  Future<TasksBack4AppModel> getTasks(bool filterNotFinished) async {
    var url = "/taskLisk";
    if (filterNotFinished) {
      url = "$url?where={\"finished\": false}";
    }
    var result = await _customDio.dio.get(url);

    return TasksBack4AppModel.fromJson(result.data);
  }

  Future<void> create(TaskBack4AppModel taskBack4AppModel) async {
    try {
      await _customDio.dio
          .post("/taskLisk", data: taskBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(TaskBack4AppModel taskBack4AppModel) async {
    try {
      await _customDio.dio.put("/taskLisk/${taskBack4AppModel.objectId}",
          data: taskBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remove(String objectId) async {
    try {
      await _customDio.dio.delete(
        "/taskLisk/$objectId",
      );
    } catch (e) {
      rethrow;
    }
  }
}
