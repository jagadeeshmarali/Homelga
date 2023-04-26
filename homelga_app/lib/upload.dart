import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

class Upload extends StatefulWidget {
  Upload({super.key});

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  int isRecording = 0;
  String assignmentName = studentAssignmentSelected.name;
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
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  iconSize: 27.0,
                  padding: const EdgeInsets.only(left: 20.0)),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        storedAudio = File('');
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Retake",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // final studentId =
                        //     FirebaseAuth.instance.currentUser?.uid;
                        // DatabaseReference userRef =
                        //     userDatabase.ref('users/$studentId');
                        // DatabaseEvent event = await userRef.once();
                        // final student = jsonEncode(event.snapshot.value);
                        // final parsedStudent = jsonDecode(student);
                        // final teacherId = parsedStudent["teacher"];
                        // print(teacherId);
                        // final teacherStorageRef = storageRef.child(teacherId);
                        // final studentStorageRef =
                        //     teacherStorageRef.child(studentId!);
                        // final assignmentStorageRef = studentStorageRef
                        //     .child(studentAssignmentSelected.name);
                        // // await userRef
                        // //     .child("assignments")
                        // //     .child(assignmentName)
                        // //     .update({"submitted": true});
                        // Directory appDocDir =
                        //     await getApplicationDocumentsDirectory();
                        // String filePath = '${appDocDir.absolute}/$storedAudio';
                        // File file = File(filePath);
                        // try {
                        //   await assignmentStorageRef.putFile(file);
                        // } on FirebaseException catch (e) {
                        //   if (e.code == 'storage/unknown') {
                        //     //
                        //   } else if (e.code == 'storage/object-not-found') {
                        //     //
                        //   }
                        // }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StudentHome()));
                      },
                      child: const Text(
                        "Upload",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 333.0,
                            height: 300.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                studentAssignmentSelected.text,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                        ]),
                    // InkWell(
                    //   onTap: () async {
                    //     setState(() {
                    //       isRecording = isRecording == 0 ? 1 : 2;
                    //     });
                    //     if(isRecording == 2) {
                    //       // Navigator.push(
                    //       //         context,
                    //       //         MaterialPageRoute(
                    //       //             builder: (context) =>
                    //       //                 const TeacherHome()));
                    //     }
                    //   },
                    //   child: Ink.image(
                    //     image: isRecording == 1 ? const AssetImage('images/stop.png') : const AssetImage('images/record.png'),
                    //     fit: BoxFit.cover,
                    //     width: 100,
                    //     height: 100,
                    //   ),
                    // )
                  ],
                ),
              ],
            )));
  }
}
