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
  final emailCtrl = TextEditingController();
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
                              controller: emailCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Student Email',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              emailCtrl.clear;
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
                                UserCredential userCredential =
                                    await FirebaseAuth.instanceFor(app: app)
                                        .createUserWithEmailAndPassword(
                                            email: emailCtrl.text,
                                            password: "homelga");
                                final user = userCredential.user;
                                final studentId = user?.uid;
                                DatabaseReference userRef =
                                    userDatabase.ref("users/$studentId");
                                await userRef.set({
                                  "name": nameCtrl.text,
                                  "type": "student",
                                  "students": {}
                                });
                                DatabaseReference teacherRef =
                                    userDatabase.ref("users/$teacherId");
                                await teacherRef
                                    .child("students")
                                    .child("$studentId")
                                    .set({
                                  "studentName": nameCtrl.text,
                                  "studentEmail:": emailCtrl.text
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
                                if (nameCtrl.text.contains(' ') &&
                                    emailCtrl.text.contains('@')) {
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
                                      'The account already exists for that email.';
                                } else if (!nameCtrl.text.contains(' ')) {
                                  errorMessage =
                                      'Please enter the student\'s full name';
                                } else if (!emailCtrl.text.contains('@')) {
                                  errorMessage =
                                      'Please provide a valid email address.';
                                } else {
                                  errorMessage =
                                      'There was an error adding a student. You must enter the student\'s full name and you must provide a valid email address. Please try again!';
                                }
                                await app.delete();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 0,
                                  content: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 183, 198, 106),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 48,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Oops Error!',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    errorMessage,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 25,
                                          left: 20,
                                          child: ClipRRect(
                                            child: Stack(
                                              children: const [
                                                Icon(
                                                  Icons.circle,
                                                  color: Color(0xFF1F7961),
                                                  size: 17,
                                                )
                                              ],
                                            ),
                                          )),
                                      Positioned(
                                          top: -20,
                                          left: 5,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF1F7961),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                              ),
                                              const Positioned(
                                                  top: 5,
                                                  child: Icon(
                                                    Icons.clear_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ))
                                            ],
                                          )),
                                    ],
                                  ),
                                ));
                              } catch (e) {
                                //errorMessage = String(e);
                                print(e);
                              }
                              emailCtrl.clear;
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
