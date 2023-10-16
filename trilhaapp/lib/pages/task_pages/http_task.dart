// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trilhaapp/model/task/tasks_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tasks_back4app_repository.dart';

class TaskPageHTTP extends StatefulWidget {
  const TaskPageHTTP({super.key});

  @override
  State<TaskPageHTTP> createState() => _TaskPageHTTPState();
}

class _TaskPageHTTPState extends State<TaskPageHTTP> {
  TasksBack4AppRepository taskRepository = TasksBack4AppRepository();

  var _taskBack4App = TasksBack4AppModel([]);
  var onlyNotFinished = false;
  TextEditingController descriptionController = TextEditingController();
  var loading = false;

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  void getTasks() async {
    setState(() {
      loading = true;
    });
    _taskBack4App = await taskRepository.getTasks(onlyNotFinished);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descriptionController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: descriptionController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          await taskRepository.create(TaskBack4AppModel.create(
                              descriptionController.text, false));
                          Navigator.pop(context);
                          getTasks();
                          setState(() {});
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtrar apenas não concluidas',
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                      value: onlyNotFinished,
                      onChanged: (bool value) {
                        onlyNotFinished = value;
                        getTasks();
                      })
                ],
              ),
            ),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _taskBack4App.tasks.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var task = _taskBack4App.tasks[index];
                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            taskRepository.remove(task.objectId);
                            getTasks();
                          },
                          key: Key(task.description),
                          child: ListTile(
                            title: Text(task.description),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                task.finished = value;
                                taskRepository.update(task);
                                getTasks();
                              },
                              value: task.finished,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
