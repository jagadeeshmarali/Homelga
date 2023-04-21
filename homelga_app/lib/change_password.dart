import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final currentPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

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
                    const Text('Change Password',
                        style: TextStyle(
                            fontSize: 48.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(height: 40.0),
                    // Image.asset('images/tree.png'),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Password',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 333.0,
                            child: TextField(
                              controller: currentPasswordCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'New Password',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 333.0,
                            child: TextField(
                              controller: newPasswordCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Confirm New Password',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 333.0,
                            child: TextField(
                              controller: confirmCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ]),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                        onPressed: () async {
                          var errorMessage = '';

                          final user = FirebaseAuth.instance.currentUser;
                          final id = user?.uid;
                          DatabaseReference userRef =
                              userDatabase.ref('users/$id');
                          DatabaseEvent event = await userRef.once();
                          final userAccount = jsonEncode(event.snapshot.value);
                          print(userAccount);
                          final parsedUser = jsonDecode(userAccount);
                          final username = parsedUser["username"];
                          print(username);
                          final password = parsedUser["password"];
                          final cred = EmailAuthProvider.credential(
                              email: '$username@homelga.com',
                              password: currentPasswordCtrl.text);

                          if (newPasswordCtrl.text == confirmCtrl.text &&
                              password == currentPasswordCtrl.text) {
                            user
                                ?.reauthenticateWithCredential(cred)
                                .then((value) {
                              user
                                  .updatePassword(newPasswordCtrl.text)
                                  .then((_) async {
                                await userRef.update({
                                  "password": newPasswordCtrl.text,
                                });
                                if (accountType == "student") {
                                  DatabaseEvent event = await userRef.once();
                                  final student =
                                      jsonEncode(event.snapshot.value);
                                  final parsedStudent = jsonDecode(student);
                                  final teacherId = parsedStudent["teacher"];
                                  print(teacherId);
                                  DatabaseReference teacherRef =
                                      userDatabase.ref('users/$teacherId');
                                  await teacherRef
                                      .child("students")
                                      .child("$id")
                                      .update({
                                    "studentPassword": newPasswordCtrl.text
                                  });
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }).catchError((error) {
                                if (error.code == 'weak-password') {
                                  errorMessage =
                                      'Your password is too weak. Please try again!';
                                } else if (error.code ==
                                    'requires-recent-login') {
                                  errorMessage =
                                      'To change your password you must login again.';
                                } else {
                                  errorMessage =
                                      'There was a problem logging into your account. Please try again!';
                                }
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
                              });
                            }).catchError((err) {});
                          } else if (newPasswordCtrl.text != confirmCtrl.text &&
                              password == currentPasswordCtrl.text) {
                            errorMessage =
                                'The passwords do not match. Please try again!';
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                      color: Color.fromARGB(255, 183, 198, 106),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                                overflow: TextOverflow.ellipsis,
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
                                              borderRadius: BorderRadius.all(
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
                          } else if (newPasswordCtrl.text == confirmCtrl.text &&
                              password != currentPasswordCtrl.text) {
                            errorMessage =
                                'Your current password is incorrect. Please try again!';
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                      color: Color.fromARGB(255, 183, 198, 106),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                                overflow: TextOverflow.ellipsis,
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
                                              borderRadius: BorderRadius.all(
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
                          } else {
                            errorMessage =
                                'There was a problem logging into your account. Please try again!';
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                      color: Color.fromARGB(255, 183, 198, 106),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                                overflow: TextOverflow.ellipsis,
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
                                              borderRadius: BorderRadius.all(
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
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F7961),
                            minimumSize: const Size(333.0, 60.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        child: const Text('Confirm',
                            style: TextStyle(
                                fontSize: 36.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500))),
                  ],
                ),
              ],
            )));
  }
}
