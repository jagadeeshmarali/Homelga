import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            const SizedBox(height: 30.0),
            Image.asset('images/tree.png'),
            const SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1F7961),
                    minimumSize: const Size(333.0, 60.0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                child: const Text('Login',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w500))),
            const SizedBox(height: 30.0),
            TextButton(
                onPressed: () {},
                child: const Text('New teacher? Create an account',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline)))
          ],
        ),
      ],
    );
  }
}
