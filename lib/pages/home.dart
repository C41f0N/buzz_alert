import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime? startTime;
  Duration? timeSinceStart;

  @override
  void initState() {
    super.initState();

    // defines a timer
    Timer.periodic(const Duration(milliseconds: 250), (Timer t) {
      setState(() {
        if (startTime != null) {
          timeSinceStart = Duration(
            milliseconds: DateTime.now().millisecondsSinceEpoch.toInt() -
                startTime!.millisecondsSinceEpoch.toInt(),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B U Z Z   A L E R T"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Buzz every "),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 60,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[900],
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text("seconds."),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (startTime == null) {
                  setState(() {
                    startTime = DateTime.now();
                  });
                } else {
                  setState(() {
                    startTime = null;
                  });
                }
              },
              child: Container(
                height: 250,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: startTime == null ? Colors.grey[900] : Colors.red,
                  borderRadius: BorderRadius.circular(250),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      startTime == null ? "S T A R T" : "S T O P",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: startTime == null ? 0 : 10,
                    ),
                    startTime == null
                        ? const SizedBox()
                        : Text(timeSinceStart.toString().substring(
                            0, timeSinceStart.toString().length - 7)),
                  ],
                ),
              ),
            ),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
