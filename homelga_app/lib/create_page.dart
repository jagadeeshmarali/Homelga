import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'login_page.dart';

class CreatePage extends StatelessWidget {
  CreatePage({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
        listener: (oldState, state, controller) {
      if (state is UserCreated) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
                        Navigator.of(context).pop();
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
                        const Text('Create Account',
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
                                'Full Name',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10.0),
                              const SizedBox(
                                width: 333.0,
                                child: TextField(
                                  decoration: InputDecoration(
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
                              const Text('Username',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  textAlign: TextAlign.left),
                              const SizedBox(height: 10.0),
                              const SizedBox(
                                width: 333.0,
                                child: TextField(
                                  decoration: InputDecoration(
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
                              const SizedBox(height: 10.0),
                              const Text(
                                'Password',
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
                                'Confirm Password',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10.0),
                              const SizedBox(
                                width: 333.0,
                                child: TextField(
                                  decoration: InputDecoration(
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
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailCtrl.text,
                                            password: passwordCtrl.text);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F7961),
                                minimumSize: const Size(333.0, 60.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            child: const Text('Login',
                                style: TextStyle(
                                    fontSize: 36.0,
                                    fontFamily: 'Playfair',
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ],
                )));
      } else if (state is SigningUp) {
        return const Center(child: CircularProgressIndicator());
      }
      return CreatePage();
    });
  }
}
