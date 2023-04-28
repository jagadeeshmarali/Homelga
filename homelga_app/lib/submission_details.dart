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

class SubmissionDetails extends StatefulWidget {
  SubmissionDetails({super.key});

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  State<SubmissionDetails> createState() => _SubmissionDetailsState();
}

class _SubmissionDetailsState extends State<SubmissionDetails> {
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String assignmentText = assignmentSelected.text;

  // @override
  // void initState() {
  //   super.initState();

  //   setAudio();

  //   audioPlayer.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       isPlaying = state == PlayerState.PLAYING;
  //     });
  //   });
  //   // audioPlayer.onDurationChanged.listen((newDuration) {
  //   //   setState(() {
  //   //     duration = newDuration;
  //   //   });
  //   // });
  //   // audioPlayer.onAudioPositionChanged.listen((newPosition) {
  //   //   setState(() {
  //   //     position = newPosition;
  //   //   });
  //   //});
  // }

  // Future setAudio() async {
  //   audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  //   audioPlayer.setUrl(audioUrl);
  // }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

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
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        studentNameSelected,
                        style: const TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
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
                            assignmentText,
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                // if (isPlaying) {
                                //   await audioPlayer.pause();
                                // } else {
                                //   await audioPlayer.resume();
                                // }
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
