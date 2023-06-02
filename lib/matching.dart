import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MemoryMatchGame extends StatefulWidget {
  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<int> itemList = [];
  List<int> openedIndexes = [];
  int previousIndex = -1;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    itemList = List<int>.generate(12, (index) => index ~/ 2);
    itemList.shuffle();
    openedIndexes = [];
    previousIndex = -1;
  }

  void onCardClicked(int index) {
    setState(() {
      if (openedIndexes.contains(index)) {
        return;
      }

      if (previousIndex != -1) {
        if (itemList[previousIndex] != itemList[index]) {
          Timer(Duration(seconds: 1), () {
            setState(() {
              openedIndexes.remove(previousIndex);
              openedIndexes.remove(index);
              previousIndex = -1;
            });
          });
        } else {
          previousIndex = -1;
        }
      } else {
        previousIndex = index;
      }

      openedIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match'),
      ),
      body: Column(children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: itemList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onCardClicked(index),
                child: Card(
                  color: openedIndexes.contains(index)
                      ? Colors.white
                      : Colors.blue,
                  child: Center(
                    child: openedIndexes.contains(index)
                        ? Text(
                            itemList[index].toString(),
                            style: TextStyle(fontSize: 24.0),
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        Text('About the Game'),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "The Memory Match game is a mind-boosting game that tests and improves your memory and cognitive skills. The objective of the game is to match pairs of cards. You will see a grid of cards displayed on the screen. Each card has a hidden value represented by a number. The numbers are randomly shuffled and distributed across the cards. The player's task is to find and match the pairs of cards with the same number. To play the game, you can tap on any card to reveal its hidden value. If you tap on a second card, the game will check if the values of the two opened cards match. If they do, the cards will remain open. Otherwise, after a brief delay, the cards will flip back to their hidden state. The game continues until you successfully match all the pairs of cards. To restart the game, you can use the floating action button (refresh icon) at the bottom right corner of the screen. By playing this game, you can exercise your memory and concentration skills by remembering the positions of the cards and making successful matches. It's a fun way to challenge yourself and enhance your cognitive abilities.",
            textAlign: TextAlign.center,
          ),
        ),
        //Text("The Memory Match game is a mind-boosting game that tests and improves your memory and cognitive skills. The objective of the game is to match pairs of cards. You will see a grid of cards displayed on the screen. Each card has a hidden value represented by a number. The numbers are randomly shuffled and distributed across the cards. The player's task is to find and match the pairs of cards with the same number. To play the game, you can tap on any card to reveal its hidden value. If you tap on a second card, the game will check if the values of the two opened cards match. If they do, the cards will remain open. Otherwise, after a brief delay, the cards will flip back to their hidden state.The game continues until you successfully match all the pairs of cards. To restart the game, you can use the floating action button (refresh icon) at the bottom right corner of the screen.By playing this game, you can exercise your memory and concentration skills by remembering the positions of the cards and making successful matches. It's a fun way to challenge yourself and enhance your cognitive abilities."),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              startGame();
            });
          }
          // startGame,
          ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: MemoryMatchGame(),
//   ));
// }