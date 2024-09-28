import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/data/model/isar_todo.dart';
import 'package:todo_list/data/repository/isar_todo_repo.dart';
import 'package:todo_list/domain/repo/todo_repo.dart';
import 'package:todo_list/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

  //open Isar db
  final isarDB = await Isar.open([TodoIsarSchema], directory: dir.path);

  //initialize the repo with Isar db
  final isarTodoRepo = IsarTodoRepo(isarDB);
  //run App
  runApp( MyApp(todoRepo: isarTodoRepo));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}


