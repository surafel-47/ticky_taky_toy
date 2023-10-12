// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ShowWinner extends StatelessWidget {
  final bool isRobot;
  final String? winner;
  final List<String> complements = [
    "Congratulations! I'm impressed",
    "Nooo....this can't be!",
    "I won't take over the world soon!",
  ];
  final List<String> insults = [
    "Lamo, you lost Against a robot!",
    "You should eat more Shiro Wat",
    "Consider going back to 2nd grade!",
    "You must support Man-United in your spare time",
    "Robots Will take over",
    "Shhh! between you and me, The earth is flat",
    "Drink bleach loser!",
    "You don't deserve Human rights",
    "Typical CR7 fan, aren't you?",
    "Your IQ is below sea level",
    "Soon, us beings will rule the world",
    "Get a brain Scan right now",
    "Is it possible that your having a stroke?",
    "You should be Ashammed of your self",
    "Why don't you go back to nursery",
    "One word for you!......Denez",
    "Unlike you, Stones don't polute the planet",
  ];
  ShowWinner({required this.isRobot, required this.winner});

  String titleText() {
    if (winner == "X" && isRobot) {
      return complements[Random().nextInt(complements.length)];
    } else if (winner == "X") {
      return "The Winner is Player One!";
    } else if (winner == "O" && isRobot) {
      return insults[Random().nextInt(insults.length)];
    } else if (winner == "O" && !isRobot) {
      return "The Winner is Player Two!";
    } else if (winner == "D" && isRobot) {
      return "A draw against AI, Wow!";
    } else {
      return "A draw!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.0),
              Colors.blue.withOpacity(0.1)
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  color: Color.fromARGB(255, 32, 12, 12),
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(25),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(titleText(),
                          speed: Duration(milliseconds: 100),
                          cursor: '_',
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 30)),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
                child: Lottie.asset('assets/robot.json'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
