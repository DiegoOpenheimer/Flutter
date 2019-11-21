import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_todo/model/ResultTask.dart';
import 'package:flutter_todo/model/Task.dart';
import 'package:flutter_todo/model/TaskDAO.dart';

class TaskBloc {

  static TaskBloc _instance = TaskBloc._internal();

  StreamController<List<Task>> _controller = StreamController();

  StreamController<int> _controllerSegment = StreamController();

  Stream<int> get segmentStream => _controllerSegment.stream;

  Stream<List<Task>> get taskStream => _controller.stream;

  List<Task> tasks = List();

  List<Task> tasksFiltered = List();

  int currentSegment = 0;

  final TaskDAO _taskDAO = TaskDAO();

  TaskBloc._internal();


  factory TaskBloc() => _instance;

  Future<void> init() async {
    tasks = await _taskDAO.getTasks();
    updateFilteredTask();
    _controller.add(tasksFiltered);
  }

  Future addTask({ @required String name }) async {
    assert(name != null);
    Task task = Task(name: name, complete: false);
    task.id = await _taskDAO.insert(task);
    tasks.add(task);
    updateFilteredTask();
    _controller.add(tasksFiltered);
  }

  Future updateStatus(Task task) async {
    await _taskDAO.update(task);
    updateFilteredTask();
    _controller.add(tasksFiltered);
  }

  Future remove(Task task) async {
    try {
      await _taskDAO.remove(task);
      tasks.removeWhere(((Task tsk) => tsk.id == task.id));
      updateFilteredTask();
      _controller.add(tasksFiltered);
    } catch (e) {
      debugPrint('Error to remove task $e');
    }
  }

  void changeSegment(int value) {
    currentSegment = value;
    updateFilteredTask();
    _controller.add(tasksFiltered);
    _controllerSegment.add(currentSegment);
  }

  void updateFilteredTask() => {
      0: () => tasksFiltered = tasks,
      1: () => tasksFiltered = tasks.where((task) => !task.complete).toList(),
      2: () => tasksFiltered = tasks.where((task) => task.complete).toList(),
  }[currentSegment]();

  ResultTask calculateResult() => ResultTask(
    completed: tasks.where((task) => task.complete).toList().length,
    pending: tasks.where((task) => !task.complete).toList().length,
    numberOfTasks: tasks.length,
  );

  void dispose() {
   _controller.close();
   _controllerSegment.close();
  }

}