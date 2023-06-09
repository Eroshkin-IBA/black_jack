import 'dart:math';

import 'package:flutter/material.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  List<Image> myCards = [];
  List<Image> dealerCards = [];

  String? dealerFirstCard;
  String? dealerSecondCard;

  String? playerFirstCard;
  String? playerSecondCard;

  int playerScore = 0;
  int dealerScore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted
          ? SafeArea(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      dealerScore <= 21
                          ? Text(
                              "Dealer's score $dealerScore",
                              style: const TextStyle(color: Colors.green),
                            )
                          : Text(
                              "$dealerScore перебор",
                              style: const TextStyle(color: Colors.red),
                            ),
                      const SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: GridView.builder(
                            itemCount: dealerCards.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: dealerCards[index],
                              );
                            }),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      playerScore <= 21
                          ? Text(
                              "player's score $playerScore",
                              style: const TextStyle(color: Colors.green),
                            )
                          : Text(
                              "$playerScore перебор",
                              style: const TextStyle(color: Colors.red),
                            ),
                      //Text("player's score $playerScore"),
                      const SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: GridView.builder(
                            itemCount: myCards.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: myCards[index],
                              );
                            }),
                      )
                    ],
                  ),
                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            if (playerScore < 21) {
                              addCard();
                            }
                          },
                          color: Colors.brown[200],
                          child: const Text("Another card"),
                        ),
                        MaterialButton(
                          onPressed: () => changeCards(),
                          color: Colors.brown[200],
                          child: const Text("Next round"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          : Center(
              child: MaterialButton(
                onPressed: () {
                  changeCards();
                },
                color: Colors.brown[200],
                child: const Text('Start game'),
              ),
            ),
    );
  }

  void changeCards() {
    setState(() {
      isGameStarted = true;
    });

    playingCards = {};
    playingCards.addAll(deckOfCards);

    myCards = [];
    dealerCards = [];

    Random random = Random();

    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => cardOneKey == key);

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => cardTwoKey == key);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => cardThreeKey == key);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => cardFourKey == key);

    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;
    playerFirstCard = cardThreeKey;
    playerSecondCard = cardFourKey;

    dealerCards.add(Image.asset(dealerFirstCard!));
    dealerCards.add(Image.asset(dealerSecondCard!));

    dealerScore =
        deckOfCards[dealerFirstCard]! + deckOfCards[dealerSecondCard]!;
    while (dealerScore < 15) {
      String dealerNextCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == dealerNextCard);
      dealerCards.add(Image.asset(dealerNextCard));
      dealerScore += deckOfCards[dealerNextCard]!;
    }
    myCards.add(Image.asset(playerFirstCard!));
    myCards.add(Image.asset(playerSecondCard!));

    playerScore =
        deckOfCards[playerFirstCard]! + deckOfCards[playerSecondCard]!;
  }

  void addCard() {
    if (playingCards.isNotEmpty) {
      Random random = Random();
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => cardKey == key);

      setState(() {
        myCards.add(Image.asset(cardKey));
        playerScore = playerScore + deckOfCards[cardKey]!;
      });
    }
  }
}
