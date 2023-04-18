import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homelga_app/start_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'teacher_home.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase userDatabase = FirebaseDatabase.instance;
List<String> studentNames = [];

class Assignment {
  String name;
  String dueDate;
  String text;

  Assignment(this.name, this.dueDate, this.text);
}

class StudentAssignment {
  String name;
  String dueDate;
  String text;
  bool submitted;

  StudentAssignment(this.name, this.dueDate, this.text, this.submitted);
}

List<Assignment> assignmentObjects = [];
List<StudentAssignment> studentAssignments = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'homelga',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const MaterialColor darkGreen = MaterialColor(
  0xFF1F7961,
  <int, Color>{
    50: Color(0xFF1F7961),
    100: Color(0xFF1F7961),
    200: Color(0xFF1F7961),
    300: Color(0xFF1F7961),
    400: Color(0xFF1F7961),
    500: Color(0xFF1F7961),
    600: Color(0xFF1F7961),
    700: Color(0xFF1F7961),
    800: Color(0xFF1F7961),
    900: Color(0xFF1F7961),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homelga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: darkGreen),
      home: const RootPage(),
    );
  }
}

/*class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const RootPage();
        }
        return const TeacherHome();
      },
    );
  }
}*/

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF1F7961),
            Color.fromARGB(255, 183, 198, 106),
          ],
        )),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: StartPage(),
        ));
  }
}
