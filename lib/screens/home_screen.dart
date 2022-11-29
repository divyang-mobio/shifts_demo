import 'package:flutter/material.dart';

import '../utils/internet_checker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shift Demo')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/openShift');
          },
          child: Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 140, 0),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(

                'Shifts',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
      ),
    );
  }
}
