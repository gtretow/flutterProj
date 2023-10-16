// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class Tarefa {
  final _id = UniqueKey().toString();
  String _description = "";
  bool _finished = false;

  Tarefa(this._description, this._finished);

  String get id => _id;
  String get description => _description;
  bool get finished => _finished;

  set description(String description) {
    _description = description;
  }

  set finished(bool finished) {
    _finished = finished;
  }
}

class TarefaRepo {
  final List<Tarefa> _tarefas = [];

  Future<void> addTask(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));

    _tarefas.add(tarefa);
  }

  Future<void> editTask(String id, bool finished) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.where((el) => el.id == id).first.finished = finished;
  }

  Future<void> removeTask(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.remove(_tarefas.where((el) => el.id == id).first);
  }

  Future<List<Tarefa>> getTask() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas;
  }

  Future<List<Tarefa>> getNotFinished() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas.where((element) => !element.finished).toList();
  }
}
