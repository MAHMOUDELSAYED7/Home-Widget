import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/task_repository.dart';
import 'presentation/view/task_screen.dart';
import 'presentation/viewmodel/task_view_model.dart';
import 'services/widget_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => TaskRepository()),
        Provider(create: (_) => WidgetService()),
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(
            context.read<TaskRepository>(),
            context.read<WidgetService>(),
          )..loadTasks(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do Widget App',
      home: TaskInputScreen(
        viewModel: context.read<TaskViewModel>(),
      ),
    );
  }
}
