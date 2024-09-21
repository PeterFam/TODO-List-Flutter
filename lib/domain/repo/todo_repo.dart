/*
    TO DO Repository

    Here we can define what the app can do

 */


import 'package:todo_list/domain/model/todo.dart';

abstract class TodoRepo{

  //get list of todos
  Future<List<Todo>> getTodoList();

  //add a new to-do
  Future<void> addTodo(Todo newTodo);

  //update an existing to-do
  Future<void> updateTodo(Todo todo);

  //delete a to-do
  Future<void> deleteTodo(Todo todo);

}