// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class TapToPlay extends StatelessWidget {
  Function(int value) toGame;
  TapToPlay({required this.toGame});
  double scrW = 0, scrH = 0;
  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: scrH * 0.7,
      child: Column(
        children: [
          Text(
            "Ticky Taky Toe",
            style: GoogleFonts.medievalSharp(
                color: Colors.white, fontSize: scrW * 0.13),
          ),
          SizedBox(height: scrH * 0.1),
          Text(
            "Tap To Play",
            style: GoogleFonts.zeyada(
                color: Colors.white,
                fontSize: scrW * 0.08,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              toGame(1);
            },
            child: Lottie.asset("assets/playB.json",
                width: scrW * 0.7, height: scrW * 0.7),
          )
        ],
      ),
    );
  }
}
