import 'package:flutter/material.dart';
import 'main.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key});

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
                    Navigator.pop(context);
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
                    Text('Student Name: ${studentSelected.name}',
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(height: 40.0),
                    Text('Student Username: ${studentSelected.username}',
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(height: 40.0),
                    Text('Student Password: ${studentSelected.password}',
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                ),
              ],
            )));
  }
}
