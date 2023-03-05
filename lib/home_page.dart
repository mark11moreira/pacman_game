import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman_game/path.dart';
import 'package:pacman_game/pixel.dart';
import 'package:pacman_game/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160,
  ];

  String direction = "right";

  void startGame() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      switch (direction) {
        case "left":
          movieLeft();
          break;
        case "right":
          movieRight();
          break;
        case "up":
          movieUp();
          break;
        case "down":
          movieDown();
          break;
      }
    });
  }

  void movieLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void movieRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void movieUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void movieDown() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
                print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                print(direction);
              },
              child: Container(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext contex, int index) {
                      if (player == index) {
                        return MyPlayer();
                      } else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.blue[800],
                          outColor: Colors.blue[900],
                          //  child: Text(index.toString()),
                        );
                      } else {
                        return MyPath(
                          innerColor: Colors.yellow,
                          outColor: Colors.black,
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score: ",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "P L A Y ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
