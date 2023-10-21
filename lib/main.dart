import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/screens/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:todoapp/loading.dart';
// import 'package:todoapp/screens/login.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Firebase.initializeApp(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//               body: Center(
//                 child: Text("Error initializing Firebase: ${snapshot.error}"),
//               ),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loading();
//           }
//           // Firebase initialization is complete
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: LoginScreen(),
//           );
//         }
//         // While Firebase is initializing, show a loading indicator or something else.
//         // return const Scaffold(
//         //   body: Center(
//         //     child: CircularProgressIndicator(), // or any other widget
//         //   ),
//         // );
//         );
//   }
// } 

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AuthenticationScreen(),
//     );
//   }
// }

// class AuthenticationScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   AuthenticationScreen({super.key});

//   void _signUp() async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       // User successfully signed up, navigate to the ToDo list.
//       // You can replace this with the appropriate navigation logic.
//     } catch (e) {
//       // ignore: avoid_print
//       print('Error signing up: $e');
//     }
//   }

//   void _signIn() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       // User successfully signed in, navigate to the ToDo list.
//       // You can replace this with the appropriate navigation logic.
//     } catch (e) {
//       // ignore: avoid_print
//       print('Error signing in: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ToDo App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Welcome to ToDo App',
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _signUp,
//               child: const Text('Sign Up'),
//             ),
//             ElevatedButton(
//               onPressed: _signIn,
//               child: const Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
