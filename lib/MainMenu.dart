// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, use_key_in_widget_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:base_temp/TapToPlay.dart';
import 'package:base_temp/tickTakToe/ticTakToeBox.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double scrW = 0, scrH = 0;
  int selectedIndex = 0;
  bool isMuted = false;
  IconData muteUnmuteBtnIcon = Icons.music_note;

  // final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    // player.play(
    //   AssetSource('moogCity.mp3'),
    // );
    // player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    List<Widget> tapToPlayOrTicTakToeBox = [
      TapToPlay(toGame: (value) {
        selectedIndex = value;

        setState(() {});
      }),
      TicTakToeBox(
        toMenu: (value) {
          selectedIndex = value;
          HapticFeedback.vibrate();
          setState(() {});
        },
      )
    ];

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Lottie.asset("assets/mainMenuBg.json", height: double.infinity, width: double.infinity, fit: BoxFit.cover),
          Column(
            children: [
              SizedBox(
                height: scrH * 0.03,
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {
                    if (isMuted) {
                      isMuted = false;
                      muteUnmuteBtnIcon = Icons.music_note;
                      // player.setVolume(1.0);
                    } else {
                      isMuted = true;
                      muteUnmuteBtnIcon = Icons.music_off;
                      // player.setVolume(0.0);
                    }
                    setState(() {});
                  },
                  icon: Icon(muteUnmuteBtnIcon, color: Colors.white, size: scrW * 0.1),
                ),
              ),
              SizedBox(
                height: scrH * 0.01,
              ),
              tapToPlayOrTicTakToeBox[selectedIndex],
              // SingleChildScrollView(
              //   child: MyAds(),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
