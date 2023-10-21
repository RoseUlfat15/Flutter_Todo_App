import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/todomodel.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("todos");

  Future<void> createNewTodo(String title) async {
    try {
      await todosCollection.add({
        "title": title,
        "isComplete": false,
      });
    } catch (e) {
      // Handle the error, e.g., log or show an error message
      // ignore: avoid_print
      print("Error creating a new todo: $e");
    }
  }

  Future<void> completeTask(String uid) async {
    try {
      await todosCollection.doc(uid).update({"isComplete": true});
    } catch (e) {
      // Handle the error
      // ignore: avoid_print
      print("Error completing task: $e");
    }
  }

  Future<void> deleteTodo(String uid) async {
    try {
      await todosCollection.doc(uid).delete();
    } catch (e) {
      // Handle the error
      // ignore: avoid_print
      print("Error removing todo: $e");
    }
  }

  Future<void> updateTodo(String todoId, String newTitle) async {
    try {
      // Reference to the todo document in Firestore
      final todoReference =
          FirebaseFirestore.instance.collection('todos').doc(todoId);

      // Update the title field
      await todoReference.update({'title': newTitle});

      // You can update other fields similarly if needed.
    } catch (e) {
      // Handle errors here, e.g., show a snackbar with an error message.
      // ignore: avoid_print
      print('Failed to update todo: $e');
      throw Exception('Failed to update todo: $e');
    }
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      final todos = snapshot.docs.map((e) {
        return Todo(
          isComplete: (e.data() as Map<String, dynamic>)["isComplete"],
          title: (e.data() as Map<String, dynamic>)["title"],
          uid: e.id,
        );
      }).toList();

      // Print the retrieved todos for debugging
      // ignore: avoid_print
      print("Retrieved todos: $todos");

      return todos;
    } else {
      return [];
    }
  }

  Stream<List<Todo>> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
