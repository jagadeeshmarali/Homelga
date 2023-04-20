import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

class Record extends StatelessWidget {
  Record({Key? key}) : super(key: key);

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

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
                              controller: nameCtrl,
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
                              controller: usernameCtrl,
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
                              controller: passwordCtrl,
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
                          Image.asset('images/record.png'),
                        ]),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                        onPressed: () async {
                          // var errorMessage = '';

                          // try {
                          //   final userCredential = await FirebaseAuth.instance
                          //       .createUserWithEmailAndPassword(
                          //           email: '${usernameCtrl.text}@homelga.com',
                          //           password: passwordCtrl.text);
                          //   final user = userCredential.user;
                          //   final id = user?.uid;
                          //   DatabaseReference userRef =
                          //       userDatabase.ref("users/$id");
                          //   await userRef.set({
                          //     "name": nameCtrl.text,
                          //     "type": "teacher",
                          //     "students": {},
                          //     "assignments": {}
                          //   });
                          //   if (nameCtrl.text.contains(' ')) {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => LoginPage()));
                          //   }
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     errorMessage =
                          //         'The password provided is too weak.';
                          //   } else if (e.code == 'email-already-in-use') {
                          //     errorMessage =
                          //         'The account already exists for that username.';
                          //   } else if (!nameCtrl.text.contains(' ')) {
                          //     errorMessage = 'Please enter your full name';
                          //   } else {
                          //     errorMessage =
                          //         'There was an error creating your account. You must enter your full name and your password must contain at least 6 characters. Please try again!';
                          //   }
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     backgroundColor: Colors.transparent,
                          //     behavior: SnackBarBehavior.floating,
                          //     elevation: 0,
                          //     content: Stack(
                          //       alignment: Alignment.center,
                          //       clipBehavior: Clip.none,
                          //       children: [
                          //         Container(
                          //           padding: const EdgeInsets.all(8),
                          //           height: 70,
                          //           decoration: const BoxDecoration(
                          //             color: Color.fromARGB(255, 183, 198, 106),
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(15)),
                          //           ),
                          //           child: Row(
                          //             children: [
                          //               const SizedBox(
                          //                 width: 48,
                          //               ),
                          //               Expanded(
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     const Text(
                          //                       'Oops Error!',
                          //                       style: TextStyle(
                          //                           fontSize: 18,
                          //                           color: Colors.white),
                          //                     ),
                          //                     Text(
                          //                       errorMessage,
                          //                       style: const TextStyle(
                          //                           fontSize: 14,
                          //                           color: Colors.white),
                          //                       maxLines: 2,
                          //                       overflow: TextOverflow.ellipsis,
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         Positioned(
                          //             bottom: 25,
                          //             left: 20,
                          //             child: ClipRRect(
                          //               child: Stack(
                          //                 children: const [
                          //                   Icon(
                          //                     Icons.circle,
                          //                     color: Color(0xFF1F7961),
                          //                     size: 17,
                          //                   )
                          //                 ],
                          //               ),
                          //             )),
                          //         Positioned(
                          //             top: -20,
                          //             left: 5,
                          //             child: Stack(
                          //               alignment: Alignment.center,
                          //               children: [
                          //                 Container(
                          //                   height: 30,
                          //                   width: 30,
                          //                   decoration: const BoxDecoration(
                          //                     color: Color(0xFF1F7961),
                          //                     borderRadius: BorderRadius.all(
                          //                         Radius.circular(15)),
                          //                   ),
                          //                 ),
                          //                 const Positioned(
                          //                     top: 5,
                          //                     child: Icon(
                          //                       Icons.clear_outlined,
                          //                       color: Colors.white,
                          //                       size: 20,
                          //                     ))
                          //               ],
                          //             )),
                          //       ],
                          //     ),
                          //   ));
                          // } catch (e) {
                          //   //errorMessage = String(e);
                          //   print(e);
                          // }
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
