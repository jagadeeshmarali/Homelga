import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'submission_list.dart';

class TeacherAssignments extends StatefulWidget {
  const TeacherAssignments({super.key});

  @override
  State<TeacherAssignments> createState() => _TeacherAssignmentsState();
}

class _TeacherAssignmentsState extends State<TeacherAssignments> {
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
                        title: const Text('Add Assignment'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Assignment Name',
                              ),
                            ),
                            TextField(
                              controller: dueCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Due Date',
                              ),
                            ),
                            //big text box for the text of the assignment
                            TextField(
                              controller: textCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Assignment Text',
                              ),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 10,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              DatabaseReference teacherRef =
                                  userDatabase.ref("users/$teacherId");
                              await teacherRef
                                  .child("assignments")
                                  .child(nameCtrl.text)
                                  .set({
                                "name": nameCtrl.text,
                                "due-date": dueCtrl.text,
                                "text": textCtrl.text
                              });
                              assignmentObjects = [];
                              DatabaseReference assignments =
                                  teacherRef.child("assignments");
                              DatabaseEvent event = await assignments.once();
                              final assignmentList =
                                  jsonEncode(event.snapshot.value);
                              final parsedAssignmentList =
                                  jsonDecode(assignmentList);
                              parsedAssignmentList.forEach((k, v) =>
                                  assignmentObjects.add(Assignment(v["name"],
                                      v["due-date"], v["text"], false)));

                              DatabaseReference students =
                                  teacherRef.child("students");
                              DatabaseEvent event2 = await students.once();
                              final studentList =
                                  jsonEncode(event2.snapshot.value);
                              final parsedStudentList = jsonDecode(studentList);
                              Future<void> setStudentAssignments(
                                  String? studentId) async {
                                DatabaseReference studentRef =
                                    userDatabase.ref("users/$studentId");
                                await studentRef
                                    .child("assignments")
                                    .child(nameCtrl.text)
                                    .set({
                                  "name": nameCtrl.text,
                                  "due-date": dueCtrl.text,
                                  "text": textCtrl.text,
                                  "submitted": false,
                                });
                              }

                              print(parsedStudentList);
                              if (parsedStudentList != null) {
                                parsedStudentList.forEach(
                                    (k, v) => setStudentAssignments(k));
                              }
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const TeacherAssignments()));
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
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var assignment in assignmentObjects)
                        Column(children: [
                          ElevatedButton(
                              onPressed: () async {
                                assignmentSelected = assignment;

                                DatabaseReference assignmentSubmissionRef =
                                    userDatabase.ref(
                                        'users/$teacherId/assignments/${assignmentSelected.name}/submissions');
                                DatabaseEvent event =
                                    await assignmentSubmissionRef.once();
                                // Future<void> setStudentsSubmitted(
                                //     String studentId) async {
                                //   String studentName = "";
                                //   DatabaseReference studentRef =
                                //       userDatabase.ref('users/$studentId');
                                //   DatabaseEvent event3 =
                                //       await studentRef.once();
                                //   final jsonStudent =
                                //       jsonEncode(event3.snapshot.value);
                                //   final parsedStudent = jsonDecode(jsonStudent);
                                //   studentName = parsedStudent["name"];
                                //   studentsSubmitted.add(student);
                                // }

                                final jsonAssignmentSubmission =
                                    jsonEncode(event.snapshot.value);
                                final parsedAssignmentSubmission =
                                    jsonDecode(jsonAssignmentSubmission);
                                print(parsedAssignmentSubmission);
                                if (parsedAssignmentSubmission != null) {
                                  parsedAssignmentSubmission.forEach(
                                      (k, v) => studentsSubmitted.add(v));
                                }
                                print(studentsSubmitted);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubmissionList()));
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
                          const SizedBox(height: 30.0),
                        ]),
                    ]),
              ),
            ),
          ),
        ));
  }
}
