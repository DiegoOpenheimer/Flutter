
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_sena/home/GameViewModel.dart';
import 'package:mega_sena/home/fragments/create_game/components/InputNumber.dart';

class CreateGame extends StatefulWidget {
  final GameViewModel gameViewModel;

  CreateGame({required this.gameViewModel});

  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late Animation? _animationPosition = Tween(begin: -100.0, end: 0.0)
      .animate(CurvedAnimation(parent: _controller!, curve: Curves.decelerate));

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
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
        ),
        AnimatedBuilder(
          animation: _animationPosition!,
          builder: (_, Widget? __) {
            return Positioned(
              right: _animationPosition?.value,
              top: 0,
              child: Lottie.asset('assets/lottie/money.json',
                  fit: BoxFit.contain, height: 100, width: 100),
            );
          },
        )
      ],
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
            child: ContainerInputNumbers(
              gameViewModel: widget.gameViewModel
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
