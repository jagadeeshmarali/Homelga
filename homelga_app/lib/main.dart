import 'package:flutter/material.dart';
import 'start_page.dart';

void main() {
  runApp(const MyApp());
}

const MaterialColor darkGreen = MaterialColor(
  0xFF1F7961,
  <int, Color>{
    50: Color(0xFF1F7961),
    100: Color(0xFF1F7961),
    200: Color(0xFF1F7961),
    300: Color(0xFF1F7961),
    400: Color(0xFF1F7961),
    500: Color(0xFF1F7961),
    600: Color(0xFF1F7961),
    700: Color(0xFF1F7961),
    800: Color(0xFF1F7961),
    900: Color(0xFF1F7961),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: darkGreen
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
        )
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: StartPage(),
      )
    );
  }
}
