import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {
  static const String _tasksKey = 'tasks';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveTasks(String tasks) async {
    final prefs = await _prefs;
    await prefs.setString(_tasksKey, tasks);
  }

  Future<String> loadTasks() async {
    final prefs = await _prefs;
    return prefs.getString(_tasksKey) ?? '';
  }

  Future<void> clearTasks() async {
    final prefs = await _prefs;
    await prefs.remove(_tasksKey);
  }
}