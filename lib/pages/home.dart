import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController delayController = TextEditingController();
  DateTime? startTime;
  Duration? timeSinceStart;
  int? deltaCount;
  int delaySecond = 60;

  @override
  void initState() {
    super.initState();

    delayController.text = delaySecond.toString();

    // defines a timer
    Timer.periodic(const Duration(milliseconds: 250), (Timer t) {
      setState(() {
        if (startTime != null && deltaCount != null) {
          timeSinceStart = Duration(
            milliseconds: DateTime.now().millisecondsSinceEpoch.toInt() -
                startTime!.millisecondsSinceEpoch.toInt(),
          );

          if (deltaCount! < timeSinceStart!.inSeconds ~/ delaySecond) {
            // vibrate

            print("Vibrating $deltaCount");

            deltaCount = deltaCount! + 1;
          }
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
                      controller: delayController,
                      onChanged: (value) {
                        if (int.tryParse(value) != null) {
                          delaySecond = int.parse(value);
                        }
                      },
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
                    deltaCount = 0;
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
