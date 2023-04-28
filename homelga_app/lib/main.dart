import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homelga_app/start_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'teacher_home.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase userDatabase = FirebaseDatabase.instance;
final storageRef = FirebaseStorage.instance.ref();
String audioUrl = "";

class Student {
  String name;
  String username;
  String password;

  Student(this.name, this.username, this.password);
}

List<Student> studentObjects = [];
List<String> studentsSubmitted = [];

class Assignment {
  String name;
  String dueDate;
  String text;
  bool submitted;

  Assignment(this.name, this.dueDate, this.text, this.submitted);
}

String accountType = "teacher";
List<Assignment> assignmentObjects = [];
List<Assignment> studentAssignments = [];
Assignment studentAssignmentSelected = {} as Assignment;
Student studentSelected = {} as Student;
List<Assignment> studentAssignmentsSubmitted = [];
Assignment assignmentSelected = {} as Assignment;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
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
