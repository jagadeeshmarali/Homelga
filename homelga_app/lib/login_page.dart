import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'teacher_home.dart';
import 'start_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'create_page.dart';

FirebaseDatabase userDatabase = FirebaseDatabase.instance;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
        listener: (oldState, state, controller) async {
      if (state is SignedIn) {
        final userRef = userDatabase.ref();
        final email = emailCtrl.text;
        final snapshot = await userRef.child('users/$id/type').get();
        if (snapshot.exists) {
          if (snapshot.value == 'teacher') {
            //go to teacher home
          } else if (snapshot.value == 'student') {
            //go to student home
          }
        } else {
          print('No data available.');
        }
      }
    }, builder: (context, state, controller, _) {
      if (state is AwaitingEmailAndPassword) {
        return Container(
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
                            onPressed: () {
                              controller.setEmailAndPassword(
                                emailCtrl.text,
                                passwordCtrl.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F7961),
                                minimumSize: const Size(333.0, 60.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
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
      } else if (state is SigningIn) {
        return const Center(child: CircularProgressIndicator());
      } /*else if (state is AuthFailed) {
        
      } */
      return LoginPage();
    });
  }
}
