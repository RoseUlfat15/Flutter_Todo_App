import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/loading.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/services/database.services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todoapp/model/todomodel.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isComplete = false;
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 33,
        backgroundColor: Colors.black,
        // title: const Text("Hello "),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Log the user out
              await FirebaseAuth.instance.signOut();
              // Navigate to the login screen
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Todo>>(
            stream: DatabaseService().listTodos(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loading();
              }
              List<Todo>? todos = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Todo Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Colors.white24,
                    ),
                    // const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                          // separatorBuilder: (context, index) => const Divider(
                          //       color: Colors.white24,
                          //     ),
                          shrinkWrap: true,
                          itemCount: todos?.length ??
                              0, // Add a null check and default to 0 if todos is null
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(todos![index]
                                  .uid), // Use a non-null assertion operator if you're certain todos and uid are non-null
                              background: Container(
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                color: Colors.amber,
                                child: const Icon(Icons.delete_outline),
                              ),
                              onDismissed: (direction) {
                                // Delete the task from Firestore
                                DatabaseService().deleteTodo(todos[index].uid);
                              },
                              child: Card(
                                color: Colors.grey[900],
                                elevation: 5,
                                margin: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    DatabaseService()
                                        .completeTask(todos[index].uid);
                                  },
                                  leading: Container(
                                      padding: const EdgeInsets.all(2),
                                      height: 25,
                                      width: 24,
                                      decoration: const BoxDecoration(
                                          // color: Theme.of(context).primaryColor,
                                          color: Colors.amber,
                                          shape: BoxShape.circle),
                                      child: todos[index].isComplete
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          : Container()),
                                  title: Text(
                                    todos[index].title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.amber),
                                      onPressed: () {
                                        // This will also open the edit dialog
                                        _showEditDialog(context, todos[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Yahaan par context provide karna hoga
              return SimpleDialog(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Row(
                  children: [
                    const Text(
                      "Add Task",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                children: [
                  const Divider(),
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    autofocus: true,
                    decoration: const InputDecoration(
                        hintText: "eg. Todo Work",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.trim().isNotEmpty) {
                          try {
                            await DatabaseService()
                                .createNewTodo(titleController.text.trim());
                            // Clear the text field
                            titleController.clear();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } catch (e) {
                            // Handle the error, e.g., show a snackbar with an error message
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to add a new task: $e',
                                  style: const TextStyle(color: Colors.amber),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.amber, // Set the text color
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showEditDialog(BuildContext context, Todo todo) {
  final updatedTitleController = TextEditingController(text: todo.title);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text(
              "Edit Task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.cancel,
                color: Colors.amber,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: updatedTitleController,
              style: const TextStyle(fontSize: 18, height: 1.5),
              decoration: const InputDecoration(
                labelText: 'Todo Title',
              ),
            ),
            // Add more fields for other properties like description, etc.
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Update the todo in Firestore
              await DatabaseService().updateTodo(
                todo.uid,
                updatedTitleController.text.trim(),
                // Update other properties as needed.
              );
              // Delay the Navigator.pop to ensure it happens after the widget is disposed.
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
              });
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
