import 'package:flutter/material.dart';
import 'teacher_home.dart';
import 'start_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseDatabase userDatabase = FirebaseDatabase.instance;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()));
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  iconSize: 24.0,
                  padding: const EdgeInsets.only(left: 20.0)),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login',
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
                            'Email',
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
                              controller: emailCtrl,
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
                          const SizedBox(height: 30.0),
                          const Text('Password',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Playfair',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              textAlign: TextAlign.left),
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
                        ]),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                        onPressed: () async {
                          var errorMessage = '';

                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailCtrl.text,
                                    password: passwordCtrl.text);
                            final user = userCredential.user;
                            final id = user?.uid;
                            /*
                            DatabaseReference typeRef =
                                userDatabase.ref('users/$id/type');
                            DatabaseEvent event = await typeRef.once();
                            final type = event.snapshot.value;
                            print(type);
                            if (type == 'teacher') {
                             //got to teacher home
                            } else if (type == 'student') {
                              //go to student home
                            } else {
                              print('No data available.');
                            } */
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TeacherHome()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              errorMessage = 'No user found for that email.';
                            } else if (e.code == 'wrong-password') {
                              errorMessage =
                                  'Wrong password provided for that user.';
                            } else {
                              errorMessage =
                                  'There was a problem logging into your account. Please try again!';
                            }
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
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F7961),
                            minimumSize: const Size(333.0, 60.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        child: const Text('Enter',
                            style: TextStyle(
                                fontSize: 36.0,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500))),
                    const SizedBox(height: 20.0),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Forgot username / password?',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline)))
                  ],
                ),
              ],
            )));
  }
}