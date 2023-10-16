// ignore_for_file: unnecessary_getters_setters

class TaskSQLiteModel {
  int _id = 0;
  String _description = "";
  bool _finished = false;

  TaskSQLiteModel(this._description, this._finished, this._id);

  int get id => _id;
  String get description => _description;
  bool get finished => _finished;

  set id(int id) {
    _id = id;
  }

  set description(String description) {
    _description = description;
  }

  set finished(bool finished) {
    _finished = finished;
  }
}
