// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:trilhaapp/model/task/tarefa.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var taskRepo = TarefaRepo();
  var _tasks = const <Tarefa>[];
  var onlyNotFinished = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  void getTasks() async {
    if (onlyNotFinished) {
      _tasks = await taskRepo.getNotFinished();
    } else {
      _tasks = await taskRepo.getTask();
    }
    _tasks = await taskRepo.getTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          await taskRepo.addTask(
                              Tarefa(descriptionController.text, false));
                          Navigator.pop(context);
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
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (BuildContext bc, int index) {
                  var task = _tasks[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await taskRepo.removeTask(task.id);
                      getTasks();
                    },
                    key: Key(task.id),
                    child: ListTile(
                      title: Text(task.description),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          await taskRepo.editTask(task.id, value);
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
