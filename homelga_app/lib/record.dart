import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'upload.dart';

class Record extends StatefulWidget {
  Record({super.key});

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  int isRecording = 0;
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    // final status = await Permission.microphone.request();

    // if (status != PermissionStatus.granted) {
    //   throw "Microphone permission not granted";
    // }

    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioUrl = path!;
    final audioFile = File(path);

    print('Recorded audio: $audioFile');
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
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Record Yourself\nReading The Following\nText',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: 'Playfair',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
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
                          // StreamBuilder<RecordingDisposition>(
                          //     stream: recorder.onProgress,
                          //     builder: (context, snapshot) {
                          //       final duration = snapshot.hasData
                          //           ? snapshot.data!.duration
                          //           : Duration.zero;

                          //       String twoDigits(int n) =>
                          //           n.toString().padLeft(5);
                          //       final twoDigitMinutes =
                          //           twoDigits(duration.inMinutes.remainder(60));
                          //       final twoDigitSeconds =
                          //           twoDigits(duration.inSeconds.remainder(60));
                          //       return Text('$twoDigitMinutes:$twoDigitSeconds',
                          //           style: const TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.bold));
                          //     })
                        ]),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isRecording = isRecording == 0 ? 1 : 2;
                        });
                        if (isRecording == 1) {
                          await record();
                        }
                        if (isRecording == 2) {
                          await stop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Upload()));
                          setState(() {
                            isRecording = 0;
                          });
                        }
                      },
                      child: Ink.image(
                        image: isRecording == 1
                            ? const AssetImage('images/stop.png')
                            : const AssetImage('images/record.png'),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
