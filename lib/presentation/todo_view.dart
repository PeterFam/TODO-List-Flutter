import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/presentation/todo_cubit.dart';

import '../domain/model/todo.dart';

/// TO-DO view
/// Responsible for UI

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoDialog(BuildContext context){
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();
    
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(controller: textController),
          actions: [
            //Cancel Button
            TextButton(onPressed: () => Navigator.of(context).pop, child: const Text('Cancel')),
            //Add Button
            TextButton(onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop;
            } , child: const Text('Add'))
          ],
        )
    );
    
  }

  @override
  Widget build(BuildContext context) {

    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _showAddTodoDialog(context)),
        body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todos) {
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    //text
                    title: Text(todo.title),
                    //check box
                    leading: Checkbox(value: todo.isCompleted, onChanged: (value) => todoCubit.toggleCompletion(todo)),
                    //delete
                    trailing: IconButton(onPressed: () => todoCubit.deleteTodo(todo), icon: const Icon(Icons.cancel)),
                  );
                });
          },
        ));
  }
}
