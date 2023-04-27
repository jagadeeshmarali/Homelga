import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/public/util/flutter_sound_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:uri_to_file/uri_to_file.dart';
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
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String assignmentName = studentAssignmentSelected.name;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    audioPlayer.setUrl(audioUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inSeconds > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Good Job!',
                  style: TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        audioUrl = "";
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
                    const SizedBox(width: 60.0),
                    ElevatedButton(
                      onPressed: () async {
                        final studentId =
                            FirebaseAuth.instance.currentUser?.uid;
                        DatabaseReference userRef =
                            userDatabase.ref('users/$studentId');
                        DatabaseEvent event = await userRef.once();
                        final student = jsonEncode(event.snapshot.value);
                        final parsedStudent = jsonDecode(student);
                        final teacherId = parsedStudent["teacher"];
                        print(teacherId);
                        final teacherStorageRef = storageRef.child(teacherId);
                        final studentStorageRef =
                            teacherStorageRef.child(studentId!);
                        final assignmentStorageRef = studentStorageRef
                            .child(studentAssignmentSelected.name);
                        DatabaseReference assignmentRef = userDatabase.ref(
                            'users/$studentId/assignments/$assignmentName');
                        await assignmentRef.update({"submitted": true});
                        List<int> list = audioUrl.codeUnits;
                        Uint8List bytes = Uint8List.fromList(list);
                        try {
                          await assignmentStorageRef.putData(bytes);
                        } on FirebaseException catch (e) {
                          if (e.code == 'storage/unknown') {
                            //
                          } else if (e.code == 'storage/object-not-found') {
                            //
                          }
                        }
                        DatabaseReference teacherAssignmentRef = userDatabase.ref(
                            'users/$teacherId/assignments/$assignmentName/submissions');
                        await teacherAssignmentRef.set({studentId: "audio"});
                        studentAssignments = [];
                        DatabaseReference assignments =
                            userRef.child("assignments");
                        DatabaseEvent event2 = await assignments.once();
                        final assignmentList =
                            jsonEncode(event2.snapshot.value);
                        final parsedAssignmentList = jsonDecode(assignmentList);
                        if (parsedAssignmentList != null) {
                          parsedAssignmentList.forEach((k, v) =>
                              studentAssignments.add(Assignment(v["name"],
                                  v["due-date"], v["text"], v["submitted"])));
                        }

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
                  ],
                ),
                const SizedBox(height: 30.0),
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
                      const SizedBox(height: 20.0),
                      // Slider(
                      //   min: 0,
                      //   max: 20,
                      //   value: position.inSeconds.toDouble(),
                      //   onChanged: (value) async {
                      //     final position = Duration(seconds: value.toInt());
                      //     await audioPlayer.seek(position);

                      //     await audioPlayer.resume();
                      //   },
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(formatTime(position)),
                      //       Text(formatTime(duration - position)),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 10.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                // setState(() {
                                //   isPlaying = !isPlaying;
                                // });
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.resume();
                                }
                              },
                              child: Ink.image(
                                image: isPlaying
                                    ? const AssetImage('images/pause.png')
                                    : const AssetImage('images/play.png'),
                                fit: BoxFit.cover,
                                width: isPlaying ? 30 : 35,
                                height: 40,
                              ),
                            )
                          ]),
                    ]),
              ],
            )));
  }
}
