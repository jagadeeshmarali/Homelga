import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'submission_details.dart';

class SubmissionList extends StatefulWidget {
  const SubmissionList({super.key});

  @override
  State<SubmissionList> createState() => _SubmissionListState();
}

class _SubmissionListState extends State<SubmissionList> {
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
            title: const Text('Submisisons',
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
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          for (var student in studentsSubmitted)
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        studentNameSelected = student;
                                        print(
                                            'Student Name Selected: $studentNameSelected');
                                        final submissionRef =
                                            FirebaseStorage.instance.refFromURL(
                                                "gs://homelga.appspot.com/$teacherId/$studentNameSelected/${assignmentSelected.name}");

                                        try {
                                          const maxSize = 1024;
                                          final Uint8List? data =
                                              await submissionRef
                                                  .getData(maxSize);
                                          print(data);
                                          audioUrl = utf8.decode(data!);
                                          print(audioUrl);
                                        } on FirebaseException catch (e) {
                                          print(e);
                                        }

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return SubmissionDetails();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(student,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontFamily: 'Playfair',
                                              fontWeight: FontWeight.w500))),
                                  const SizedBox(height: 2.5),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                  const SizedBox(height: 2.5),
                                ])
                        ]))),
              ]),
            ],
          ),
        ));
  }
}
