import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: const TicTacToe(),
    ),
  ));
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  bool isXTurn = true;
  String result = '';

  void checkResult() {
    List<String> lines = [
      '${board[0]}${board[1]}${board[2]}',
      '${board[3]}${board[4]}${board[5]}',
      '${board[6]}${board[7]}${board[8]}',
      '${board[0]}${board[3]}${board[6]}',
      '${board[1]}${board[4]}${board[7]}',
      '${board[2]}${board[5]}${board[8]}',
      '${board[0]}${board[4]}${board[8]}',
      '${board[2]}${board[4]}${board[6]}',
    ];

    if (lines.any((element) => element == 'XXX')) {
      setState(() {
        result = 'X wins!';
      });
    } else if (lines.any((element) => element == 'OOO')) {
      setState(() {
        result = 'O wins!';
      });
    } else if (board.every((element) => element != '')) {
      setState(() {
        result = 'It\'s a tie!';
      });
    }
  }

  void playGame(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
      });
      checkResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: board.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () => playGame(index),
                  child: Text(
                    board[index],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                board = ['', '', '', '', '', '', '', '', ''];
                isXTurn = true;
                result = '';
              });
            },
            child: const Text(
              'Reset Game',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}