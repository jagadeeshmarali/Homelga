import 'package:flutter/material.dart';
import 'students.dart';
import 'teacher_assignments.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
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
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Hello Teacher!',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                const SizedBox(height: 60.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Students()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F7961),
                        minimumSize: const Size(333.0, 200.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    child: const Text('Students',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500))),
                const SizedBox(height: 40.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TeacherAssignments()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F7961),
                        minimumSize: const Size(333.0, 200.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    child: const Text('Assignments',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500))),
              ]),
            ],
          ),
        ));
  }
}
