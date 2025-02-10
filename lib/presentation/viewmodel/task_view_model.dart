import 'package:flutter/foundation.dart';
import '../../data/task_repository.dart';
import '../../services/widget_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository;
  final WidgetService _widgetService;
  
  String _tasks = '';
  String get tasks => _tasks;
  List<String> get taskList => _tasks.isNotEmpty ? _tasks.split(',') : [];

  TaskViewModel(this._repository, this._widgetService);

  Future<void> loadTasks() async {
    _tasks = await _repository.loadTasks();
    notifyListeners();
    await _updateWidget();
  }

  Future<void> addTask(String newTask) async {
    if (newTask.isEmpty) return;
    
    _tasks = _tasks.isEmpty ? newTask : '$_tasks,$newTask';
    await _repository.saveTasks(_tasks);
    notifyListeners();
    await _updateWidget();
  }

  Future<void> removeTask(int index) async {
    final tasks = taskList;
    if (index >= tasks.length) return;
    
    tasks.removeAt(index);
    _tasks = tasks.join(',');
    await _repository.saveTasks(_tasks);
    notifyListeners();
    await _updateWidget();
  }

  Future<void> _updateWidget() async {
    await _widgetService.updateWidget();
  }
}