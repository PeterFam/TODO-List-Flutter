/*
    ISAR To Model

    Converts to-do model into isar to-do model that we can store in our db

 */


import 'package:isar/isar.dart';

import '../../domain/model/todo.dart';

//generate isar to-do object, run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar{
  Id id = Isar.autoIncrement;
  late String title;
  late bool isCompleted;

  Todo toDomain(){
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted
    );
  }

  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
        ..id = todo.id
        ..title = todo.title
        ..isCompleted = todo.isCompleted;
  }
}