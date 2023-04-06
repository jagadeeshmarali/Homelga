import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
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
                iconSize: 27.0,
                padding: const EdgeInsets.only(left: 20.0)),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  iconSize: 27.0,
                  padding: const EdgeInsets.only(right: 20.0)),
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Students',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 20.0),
                Container(
                    width: 333.0,
                    height: 500.0,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return CreatePage();
                                //     },
                                //   ),
                                // );
                              },
                              child: const Text('Student 1',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w500))),
                          const SizedBox(height: 10.0),
                          TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return CreatePage();
                                //     },
                                //   ),
                                // );
                              },
                              child: const Text('Student 1',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w500))),
                          const SizedBox(height: 10.0),
                          TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return CreatePage();
                                //     },
                                //   ),
                                // );
                              },
                              child: const Text('Student 1',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontFamily: 'Playfair',
                                      fontWeight: FontWeight.w500))),
                        ])),
              ]),
            ],
          ),
        ));
  }
}
