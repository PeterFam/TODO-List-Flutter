

import 'package:isar/isar.dart';
import 'package:todo_list/data/model/isar_todo.dart';
import 'package:todo_list/domain/model/todo.dart';
import 'package:todo_list/domain/repo/todo_repo.dart';

class IsarTodoRepo implements TodoRepo{

  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo newTodo) async {
    //convert to-do object to todoIsar in order to insert it to db
   final todos = TodoIsar.fromDomain(newTodo);

   //take the todoIsar object and insert it to db
   return db.writeTxn(() => db.todoIsars.put(todos));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodoList() async {
    //fetch from db
    final todos = await db.todoIsars.where().findAll();

    //return as a list of todos and given to domain layer
    return todos.map((todosIsar) => todosIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    //convert to-do object to todoIsar in order to update it to db
    final todos = TodoIsar.fromDomain(todo);

    //take the todoIsar object and insert it to db
    return db.writeTxn(() => db.todoIsars.put(todos));
  }
  
}