import 'package:trilhaapp/model/task/task_model_sqlite.dart';
import 'database.dart';

class TaskSQLiteRepo {
  Future<List<TaskSQLiteModel>> getData(bool onlyNotFinished) async {
    List<TaskSQLiteModel> tasks = [];
    var db = await SQLiteDataBase().getData();
    var result = await db.rawQuery(onlyNotFinished
        ? 'SELECT id, description, finished FROM tasks WHERE finished = 0'
        : 'SELECT id, description, finished FROM tasks');
    for (var element in result) {
      tasks.add(TaskSQLiteModel(element['description'].toString(),
          element['finished'] == 1, int.parse(element['id'].toString())));
    }

    return tasks;
  }

  Future<void> save(TaskSQLiteModel taskSQLiteModel) async {
    var db = await SQLiteDataBase().getData();
    await db.rawInsert('INSERT INTO tasks (description, finished) values(?,?)',
        [taskSQLiteModel.description, taskSQLiteModel.finished]);
  }

  Future<void> edit(TaskSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDataBase().getData();
    await db.rawInsert(
        'UPDATE tasks SET description = ?, finished = ? WHERE id = ?', [
      tarefaSQLiteModel.description,
      tarefaSQLiteModel.finished ? 1 : 0,
      tarefaSQLiteModel.id
    ]);
  }

  Future<void> delete(int id) async {
    var db = await SQLiteDataBase().getData();
    await db.rawInsert('DELETE FROM tasks WHERE id = ?', [id]);
  }
}
