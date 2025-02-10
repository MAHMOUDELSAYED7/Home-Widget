import 'package:flutter/material.dart';

import '../viewmodel/task_view_model.dart';

class TaskInputScreen extends StatelessWidget {
  final TaskViewModel viewModel;

  const TaskInputScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: viewModel.taskList.length,
            itemBuilder: (context, index) => _buildTaskItem(context, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTaskDialog(context),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    final task = viewModel.taskList[index];
    return Dismissible(
      key: Key(task),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _handleDismiss(context, index),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        child: ListTile(
          title: Text(task, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  void _handleDismiss(BuildContext context, int index) {
    viewModel.removeTask(index);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task removed!')),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter task'),
        ),
        actions: [
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              viewModel.addTask(controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
