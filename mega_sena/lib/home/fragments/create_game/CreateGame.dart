import 'package:flutter/material.dart';
import 'package:mega_sena/home/GameViewModel.dart';
import 'package:mega_sena/home/fragments/create_game/components/InputNumber.dart';

class CreateGame extends StatefulWidget {
  final GameViewModel gameViewModel;

  CreateGame({required this.gameViewModel});

  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Criar jogo',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildFields(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFields(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Se quiser, você pode informar valores para serem inclusos no sorteio',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ContainerInputNumbers(gameViewModel: widget.gameViewModel),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
