class TasksBack4AppModel {
  List<TaskBack4AppModel> tasks = [];

  TasksBack4AppModel(this.tasks);

  TasksBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tasks = <TaskBack4AppModel>[];
      json['results'].forEach((v) {
        tasks.add(TaskBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tasks.map((v) => v.toJson()).toList();
    return data;
  }
}

class TaskBack4AppModel {
  String objectId = "";
  String description = "";
  bool finished = false;
  String createdAt = "";
  String updatedAt = "";

  TaskBack4AppModel(this.objectId, this.description, this.finished,
      this.createdAt, this.updatedAt);

  TaskBack4AppModel.create(this.description, this.finished);

  TaskBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    description = json['description'];
    finished = json['finished'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['description'] = description;
    data['finished'] = finished;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['finished'] = finished;
    return data;
  }
}
