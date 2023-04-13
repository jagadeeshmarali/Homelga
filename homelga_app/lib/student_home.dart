import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final nameCtrl = TextEditingController();
  final dueCtrl = TextEditingController();
  final textCtrl = TextEditingController();
  final teacherId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF1F7961),
            Color.fromARGB(255, 183, 198, 106),
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Assignments',
                style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                },
                icon: const Icon(Icons.settings),
                color: Colors.white,
                iconSize: 27.0,
                padding: const EdgeInsets.only(left: 20.0)),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var assignment in studentAssignments)
                        ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const Students()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F7961),
                                minimumSize: const Size(333.0, 150.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            child: Column(children: [
                              Text(assignment.name,
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 20.0),
                              Text('Due Date: ${assignment.dueDate}',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70)),
                            ])),
                      const SizedBox(height: 40.0),
                    ]),
              ),
            ),
          ),
        ));
  }
}
