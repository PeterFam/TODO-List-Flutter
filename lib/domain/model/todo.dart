/*
TO DO Model
 */

class Todo{
  final int id;
  final String title;
  final bool isCompleted;

  Todo({required this.id,
    required this.title,
    this.isCompleted = false //initially, to-do is incomplete
  });

  Todo toggleCompletion(){
    return Todo(id: id,
    title: title,
    isCompleted: !isCompleted
    );
  }

}