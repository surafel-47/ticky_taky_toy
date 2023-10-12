// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:base_temp/tickTakToe/ticTacToGridPvP.dart';
import 'package:base_temp/tickTakToe/ticTacToGridPvR.dart';

class TicTakToeBox extends StatefulWidget {
  Function(int value) toMenu;
  TicTakToeBox({required this.toMenu});
  @override
  State<TicTakToeBox> createState() => _TicTakToeBoxState();
}

class _TicTakToeBoxState extends State<TicTakToeBox> {
  bool isRobot = false;
  double scrW = 0, scrH = 0;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> ticTacToeWhich = [TicTakToeGridPvP(), TicTakToeGridPvR()];

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        widget.toMenu(0);
        return false;
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: scrH * 0.7,
        child: Column(
          children: [
            LiteRollingSwitch(
              animationDuration: Duration(milliseconds: 200),
              width: scrW * 0.2,
              textOff: "",
              textOn: "",
              iconOff: Icons.people,
              iconOn: Icons.laptop_chromebook_outlined,
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              onChanged: (value) {
                isRobot = value;
                if (value == false) {
                  selectedIndex = 0;
                } else if (value == true) {
                  selectedIndex = 1;
                }
                setState(() {});
              },
            ),
            SizedBox(
              height: scrH * 0.05,
            ),
            ticTacToeWhich[selectedIndex],
          ],
        ),
      ),
    );
  }
}
