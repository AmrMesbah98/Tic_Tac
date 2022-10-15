import 'dart:math';

class Player {
  static List playerX = [];
  static List playerO = [];
}

extension ContainAll on List {
  containall(int x, int y, int z) {
    Player.playerX.contains(x) &&
        Player.playerX.contains(y) &&
        Player.playerX.contains(z);
  }
}

class Game {
  String checkWiner() {
    String winner = '';

    if (Player.playerX.containall(0, 1, 2) ||
        Player.playerX.containall(3, 4, 5) ||
        Player.playerX.containall(6, 7, 8) ||
        Player.playerX.containall(0, 3, 6) ||
        Player.playerX.containall(1, 4, 7) ||
        Player.playerX.containall(2, 5, 8) ||
        Player.playerX.containall(0, 4, 8) ||
        Player.playerX.containall(2, 4, 6)) {
      winner = 'x';
    }

    if (Player.playerO.containall(0, 1, 2) ||
        Player.playerO.containall(3, 4, 5) ||
        Player.playerO.containall(6, 7, 8) ||
        Player.playerO.containall(0, 3, 6) ||
        Player.playerO.containall(1, 4, 7) ||
        Player.playerO.containall(2, 5, 8) ||
        Player.playerO.containall(0, 4, 8) ||
        Player.playerO.containall(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }

    return winner;
  }

  void palyGame(int index, String activePlayer) {
    if (activePlayer == 'X')
      Player.playerX.add(index);
    else
      Player.playerO.add(index);
  }

  Future autoplay(activeplayer) async {
    int index = 0;

    List empitycells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || (Player.playerO.contains(i))))
        empitycells.add(i);
    }

    Random random = Random();
    int randomindex = random.nextInt(empitycells.length);

    index = empitycells[randomindex];

    palyGame(index, activeplayer);
  }
}
