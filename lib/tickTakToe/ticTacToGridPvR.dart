// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unrelated_type_equality_checks, file_names, must_be_immutable

import 'dart:ui';

import 'package:base_temp/tickTakToe/showWinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, String> itmLst = {
  0: "",
  1: "",
  2: "",
  3: "",
  4: "",
  5: "",
  6: "",
  7: "",
  8: "",
};

void resetTwoDArray() {
  for (int key in itmLst.keys) {
    itmLst[key] = "";
  }
}

class TicTakToeGridPvR extends StatefulWidget {
  bool isRobot;
  TicTakToeGridPvR({this.isRobot = false});
  @override
  State<TicTakToeGridPvR> createState() => _TicTakToeGridState();
}

class _TicTakToeGridState extends State<TicTakToeGridPvR> {
  @override
  void initState() {
    super.initState();
    resetTwoDArray();
    //print(itmLst);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.01),
                    Colors.white.withOpacity(0.1)
                  ],
                ),
              ),
            ),
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, index) {
                return XOgrids(
                    index: index,
                    setUpperState: () {
                      setState(() {});
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

// void printBoard() {
//   for (var i = 0; i < 9; i += 3) {
//     print('${itmLst[i]} | ${itmLst[i + 1]} | ${itmLst[i + 2]}');
//     if (i < 6) print('--+---+--');
//   }
// }

class XOgrids extends StatefulWidget {
  int index;
  Function setUpperState;
  XOgrids({required this.index, required this.setUpperState});
  @override
  State<XOgrids> createState() => _XOgridsState();
}

class _XOgridsState extends State<XOgrids> {
  String xOrY = "";
  Color gridColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.vibrate();
        if (itmLst[widget.index] != "X" && itmLst[widget.index] != "O") {
          gridColor = Color.fromARGB(255, 113, 13, 6).withOpacity(0.3);
          itmLst[widget.index] = "X";
          setState(() {});
          // print("PlayerMoved");
          // printBoard();
          ComputerMove();
          widget.setUpperState();
          // print("AiMoved");
          // printBoard();

          String? winner = CalculateWinner();
          // print(winner);
          if (winner != "") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ShowWinner(
                  isRobot: true,
                  winner: winner,
                );
              },
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: makeItNice(widget.index),
          color: gridColor,
        ),
        child: Center(
          child: Text(
            itmLst[widget.index]!,
            style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.2),
          ),
        ),
      ),
    );
  }
}

BorderSide borSide =
    BorderSide(color: Colors.white, width: 3, style: BorderStyle.solid);
Border makeItNice(int index) {
  if (index == 0 || index == 1 || index == 3 || index == 4) {
    return Border(bottom: borSide, right: borSide);
  } else if (index == 2 || index == 5) {
    return Border(bottom: borSide);
  } else if (index == 6 || index == 7) {
    return Border(right: borSide);
  }
  return Border();
}

String? CalculateWinner() {
  // side ways check
  if (itmLst[0] == itmLst[1] && itmLst[1] == itmLst[2]) return itmLst[1];
  if (itmLst[3] == itmLst[4] && itmLst[4] == itmLst[5]) return itmLst[4];
  if (itmLst[6] == itmLst[7] && itmLst[7] == itmLst[8]) return itmLst[7];

  //downwardcheck
  if (itmLst[0] == itmLst[3] && itmLst[3] == itmLst[6]) return itmLst[3];
  if (itmLst[1] == itmLst[4] && itmLst[4] == itmLst[7]) return itmLst[4];
  if (itmLst[2] == itmLst[5] && itmLst[5] == itmLst[8]) return itmLst[5];

  //crosscheck
  if (itmLst[0] == itmLst[4] && itmLst[4] == itmLst[8]) return itmLst[4];
  if (itmLst[2] == itmLst[4] && itmLst[4] == itmLst[6]) return itmLst[4];

  //if draw
  if (checkDraw()) return "D";

  return "";
}

bool checkDraw() {
  for (var value in itmLst.values) {
    if (value == "") {
      return false;
    }
  }
  return true;
}

// ignore: body_might_complete_normally_nullable
int? ComputerMove() {
  int? index;

  // Check if there is a winning move for the computer
  index = findWinningMove('O');
  if (index != null) {
    itmLst[index] = 'O';
    return index;
  }

  // Check if the user is about to win and block their move
  index = findWinningMove('X');
  if (index != null) {
    itmLst[index] = 'O';
    return index;
  }

  // Check if the center square is available
  if (itmLst[4] == '') {
    itmLst[4] = 'O';
    return index;
  }

  // Check if there is a corner square available
  index = findEmptySquare([0, 2, 6, 8]);
  if (index != null) {
    itmLst[index] = 'O';
    return index;
  }

  // Take an available side square
  index = findEmptySquare([1, 3, 5, 7]);
  if (index != null) {
    itmLst[index] = 'O';
    return index;
  }
}

int? findEmptySquare(List<int> squares) {
  for (int square in squares) {
    if (itmLst[square] == '') {
      return square;
    }
  }
  return null;
}

int? findWinningMove(String symbol) {
  // Check rows for winning move
  for (int i = 0; i < 9; i += 3) {
    if (itmLst[i] == symbol && itmLst[i + 1] == symbol && itmLst[i + 2] == '') {
      return i + 2;
    }
    if (itmLst[i] == symbol && itmLst[i + 2] == symbol && itmLst[i + 1] == '') {
      return i + 1;
    }
    if (itmLst[i + 1] == symbol && itmLst[i + 2] == symbol && itmLst[i] == '') {
      return i;
    }
  }

  // Check columns for winning move
  for (int i = 0; i < 3; i++) {
    if (itmLst[i] == symbol && itmLst[i + 3] == symbol && itmLst[i + 6] == '') {
      return i + 6;
    }
    if (itmLst[i] == symbol && itmLst[i + 6] == symbol && itmLst[i + 3] == '') {
      return i + 3;
    }
    if (itmLst[i + 3] == symbol && itmLst[i + 6] == symbol && itmLst[i] == '') {
      return i;
    }
  }

  // Check diagonals for winning move
  if (itmLst[0] == symbol && itmLst[4] == symbol && itmLst[8] == '') {
    return 8;
  }
  if (itmLst[0] == symbol && itmLst[8] == symbol && itmLst[4] == '') {
    return 4;
  }
  if (itmLst[4] == symbol && itmLst[8] == symbol && itmLst[0] == '') {
    return 0;
  }
  if (itmLst[2] == symbol && itmLst[4] == symbol && itmLst[6] == '') {
    return 6;
  }
  if (itmLst[2] == symbol && itmLst[6] == symbol && itmLst[4] == '') {
    return 4;
  }
  if (itmLst[4] == symbol && itmLst[6] == symbol && itmLst[2] == '') {
    return 2;
  }

  return null;
}
