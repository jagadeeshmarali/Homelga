import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        children: const [
                          Text('Username',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Playfair',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              textAlign: TextAlign.left),
                          SizedBox(height: 10.0),
                          SizedBox(
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
                          SizedBox(height: 30.0),
                          Text('Password',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Playfair',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              textAlign: TextAlign.left),
                          SizedBox(height: 10.0),
                          SizedBox(
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
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //       return const LoginPage();
                          //     },
                          //   ),
                          // );
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
