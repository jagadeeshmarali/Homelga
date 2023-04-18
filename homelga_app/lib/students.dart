import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final usernameCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final teacherId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
            title: const Text('Students',
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
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 27.0,
                padding: const EdgeInsets.only(left: 20.0)),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Add Student'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Student Name',
                              ),
                            ),
                            TextField(
                              controller: usernameCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Student Username',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              usernameCtrl.clear;
                              nameCtrl.clear;
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              FirebaseApp app = await Firebase.initializeApp(
                                  name: 'Secondary',
                                  options: Firebase.app().options);
                              var errorMessage = '';

                              try {
                                UserCredential userCredential = await FirebaseAuth
                                        .instanceFor(app: app)
                                    .createUserWithEmailAndPassword(
                                        email:
                                            '${usernameCtrl.text}@homelga.com',
                                        password: "homelga");
                                final user = userCredential.user;
                                final studentId = user?.uid;
                                DatabaseReference userRef =
                                    userDatabase.ref("users/$studentId");
                                await userRef.set({
                                  "name": nameCtrl.text,
                                  "type": "student",
                                  "password": "homelga",
                                  "students": {}
                                });
                                DatabaseReference teacherRef =
                                    userDatabase.ref("users/$teacherId");
                                await teacherRef
                                    .child("students")
                                    .child("$studentId")
                                    .set({
                                  "studentName": nameCtrl.text,
                                  "studentUsername:": usernameCtrl.text
                                });
                                studentNames.clear();
                                DatabaseReference students =
                                    teacherRef.child("students");
                                DatabaseEvent event = await students.once();
                                final studentList =
                                    jsonEncode(event.snapshot.value);
                                final parsedStudentList =
                                    jsonDecode(studentList);

                                parsedStudentList.forEach((k, v) =>
                                    studentNames.add(v["studentName"]));
                                if (nameCtrl.text.contains(' ')) {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const Students()));
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'email-already-in-use') {
                                  errorMessage =
                                      'The account already exists for that username.';
                                } else if (!nameCtrl.text.contains(' ')) {
                                  errorMessage =
                                      'Please enter the student\'s full name';
                                } else {
                                  errorMessage =
                                      'There was an error adding a student. You must enter the student\'s full name. Please try again!';
                                }
                                await app.delete();
                              } catch (e) {
                                //errorMessage = String(e);
                                print(e);
                              }
                              usernameCtrl.clear;
                              nameCtrl.clear;
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  iconSize: 27.0,
                  padding: const EdgeInsets.only(right: 20.0)),
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 333.0,
                    height: screenHeight * 0.8,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var studentName in studentNames)
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) {
                                  //       return CreatePage();
                                  //     },
                                  //   ),
                                  // );
                                },
                                child: Text(studentName,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontFamily: 'Playfair',
                                        fontWeight: FontWeight.w500))),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                          const SizedBox(height: 5.0),
                        ])),
              ]),
            ],
          ),
        ));
  }
}
