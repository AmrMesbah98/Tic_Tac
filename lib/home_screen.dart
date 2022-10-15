import 'package:flutter/material.dart';
import 'package:tic_tac_game/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  int trun = 0;
  bool gameOver = false;
  Game game = Game();
  String result = '';
  bool is_switch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text(
              "turn on/of two player",
              style: TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            value: is_switch,
            onChanged: (newval) {
              setState(() {
                is_switch = newval;
              });
            },
          ),
          Text(
            "it's $activePlayer Turn ".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 45,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _onTap(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        Player.playerX.contains(index)
                            ? 'X'
                            : Player.playerO.contains(index)
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.playerX.contains(index)
                              ? Colors.blue
                              : Colors.red,
                          fontSize: 45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            result,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 45,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).splashColor)),
            onPressed: () {
              setState(() {
                Player.playerO = [];
                Player.playerX = [];
                activePlayer = 'X';
                trun = 0;
                gameOver = false;
                result = '';
                is_switch = false;
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text("Repet the game"),
          ),
        ],
      )),
    );
  }

  _onTap(int index) async {
    if (is_switch && !gameOver) {
      await game.autoplay(activePlayer);
      update_setstate();
    }

    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.palyGame(index, activePlayer);
      update_setstate();
    }
  }

  void update_setstate() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';

      
      String WinnerPlay = game.checkWiner();

      if (WinnerPlay != '') {
        result = '$WinnerPlay is winner';
      } else {
        result = "its Draw";
      }
    });
  }
}
