/// To DO Cubit
///  Simple state management


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/model/todo.dart';
import 'package:todo_list/domain/repo/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{

  //Create Reference for to-do repo
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo): super([]){
    //load to-do list as it is the initial state
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodoList();

    //emit the fetched to-do list as the new state
    emit(todoList);
  }

  Future<void> addTodo(String newInsertedTodo) async{
    //Create a new to-do with unique id
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, title: newInsertedTodo);

    //insert the create to-do object to the db
    await todoRepo.addTodo(newTodo);

    //reload all to-do to update the UI
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    //delete the provided to-do from db
    await todoRepo.deleteTodo(todo);

    //reload all to-do to update the UI
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    //toggle the completion status of provided to-do
    final updatedTodo = todo.toggleCompletion();

    //update the to-do in repo with the new completion status
    await todoRepo.updateTodo(updatedTodo);

    //reload all to-do to update UI
    loadTodos();
  }
}