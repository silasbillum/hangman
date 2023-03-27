import 'package:flutter/material.dart';
import 'package:hangman/colors.dart';
import 'package:hangman/utils/game.dart';
import 'package:hangman/widget/figure.dart';
import 'package:hangman/widget/letters.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';

void main() {
  List<String> word = nouns.take(1000).map((e) => e.toUpperCase()).toList();
  List<String> uppercaseWords = word.map((word) => word.toUpperCase()).toList();
  List<String> shortWords = uppercaseWords.where((word) => word.length <= 7).toList();
  runApp(MyApp(shortWords: shortWords));
}

class MyApp extends StatelessWidget {
  final List<String> shortWords;
  MyApp({Key? key, required this.shortWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(shortWords: shortWords),
    );
  }
}

class HomeApp extends StatefulWidget {
  final List<String> shortWords;
  HomeApp({Key? key, required this.shortWords}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  bool gameEnded = false;
  String selectedWord = "";
  Random random = Random();
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];

  @override
  void initState() {

    super.initState();
    selectedWord = widget.shortWords[random.nextInt(widget.shortWords.length)];
  }

  @override
  Widget build(BuildContext context) {
    if (Game.selectedChar.toSet().containsAll(selectedWord.split('').toSet())) {
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations, you win!',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                'The Word is: ${selectedWord}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    Game.tries = 0;
                    Game.selectedChar.clear();
                    selectedWord = widget.shortWords[random.nextInt(widget.shortWords.length)];
                  });
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        ),
      );
    }
    if (Game.tries >= 7) {
      return Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: Center(
          child: Text(
          'The word was: ${selectedWord}',
          style: TextStyle(fontSize: 24, color: Colors.white),
    ),
    ),
    bottomNavigationBar: BottomAppBar(
      color: AppColor.primaryColorDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
           child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
        ),
               onPressed: () {
                  setState(() {
                    Game.tries = 0;
                      Game.selectedChar.clear();
                        selectedWord = widget.shortWords[random.nextInt(widget.shortWords.length)];
          });
           },
                child: Text('Restart Game'),
          ),
            ),

          ],
        ),
       ),
      );
    }
    else{

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Hangman"),
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColor.primaryColorDark,
          ),
          body: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    figure(Game.tries >= 0, "assets/0.png"),
                    figure(Game.tries >= 1, "assets/1.PNG"),
                    figure(Game.tries >= 2, "assets/2.PNG"),
                    figure(Game.tries >= 3, "assets/3.PNG"),
                    figure(Game.tries >= 4, "assets/4.PNG"),
                    figure(Game.tries >= 5, "assets/5.PNG"),
                    figure(Game.tries >= 6, "assets/6.PNG"),
                    figure(Game.tries >= 7, "assets/7.PNG"),

                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: selectedWord.split("").map((e) =>
                    letters(e.toUpperCase(),
                        !Game.selectedChar.contains(e.toUpperCase()))).toList(),
              ),

              SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: GridView.count(
                    crossAxisCount: 6,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 8,
                    padding: EdgeInsets.all(8),
                    children: alphabets.map((e) {
                      return RawMaterialButton(
                        onPressed: Game.selectedChar.contains(e) ? null : () {
                          setState(() {
                            Game.selectedChar.add(e);
                            print(Game.selectedChar);
                            if (!selectedWord.split("").contains(
                                e.toUpperCase())) {
                              Game.tries++;
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(e, style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),),
                        fillColor: Game.selectedChar.contains(e) ? Colors.black87
                            : AppColor.primaryColorDark,
                      );
                    }).toList(),
                  )
              )
            ],
          ),

          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,),
                    onPressed: () {

                      setState(() {
                        Game.tries = 0;
                        Game.selectedChar.clear();
                        selectedWord = widget.shortWords[random.nextInt(widget.shortWords.length)];
                      });
                    },
                    child: Text('Restart Game'),
                  ),
                ),
              ],
            ),
          ),
        );

      }
    }
  }
