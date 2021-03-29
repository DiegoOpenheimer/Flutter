import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_sena/GameViewModel.dart';
import 'package:mega_sena/create_game/components/InputNumber.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late Animation? _animationPosition = Tween(begin: -100.0, end: 0.0)
      .animate(CurvedAnimation(parent: _controller!, curve: Curves.decelerate));
  final GameViewModel _gameViewModel = GameViewModel();
  final ScrollController _scrollController = ScrollController();

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
          controller: _scrollController,
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
            child: ContainerInputNumbers(gameViewModel: _gameViewModel, onGenerated: () {
              _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
            },),
          ),
          SizedBox(
            height: 16,
          ),
          _buildValues(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildValues() {
    return ValueListenableBuilder(
      valueListenable: _gameViewModel.generatedValues,
      builder: (context, values, child) {
        return Align(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 32,
            children: [
              for (int i = 0;
                  i < _gameViewModel.generatedValues.value.length;
                  i++)
                TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500 * (i + 1)),
                  builder: (_, double opacity, Widget? child) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                  child: Text(
                    _gameViewModel.generatedValues.value[i],
                    style: TextStyle(fontSize: 32),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
