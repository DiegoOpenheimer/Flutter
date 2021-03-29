import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mega_sena/GameViewModel.dart';
import 'package:mega_sena/shared/Utils.dart';

class ContainerInputNumbers extends StatefulWidget {
  final GameViewModel gameViewModel;
  final VoidCallback? onGenerated;

  ContainerInputNumbers({required this.gameViewModel, this.onGenerated});

  @override
  _ContainerInputNumbersState createState() => _ContainerInputNumbersState();
}

class _ContainerInputNumbersState extends State<ContainerInputNumbers> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, _) {
        return buildColumn();
      },
      valueListenable: widget.gameViewModel.amountValues,
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Número do sorteio (opcional)'),
        ),
        SizedBox(
          height: 32,
        ),
        buildWrap(),
        SizedBox(
          height: 32,
        ),
        _buildSlider(),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                onPressed: widget.gameViewModel.clearFields,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                tooltip: 'Limpar campos'),
            SizedBox(
              width: 32,
            ),
            FloatingActionButton(
                onPressed: () {
                  widget.gameViewModel.generated();
                  widget.onGenerated?.call();
                },
                child: Icon(
                  Icons.create,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
                tooltip: 'Gerar jogo'),
            SizedBox(
              width: 32,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
              tooltip: 'Salvar jogo',
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return Row(
      children: [
        Text(widget.gameViewModel.amountValues.value.toString()),
        Expanded(
          child: Slider(
            min: GameViewModel.AMOUNT_OF_VALUES_DEFAULT.toDouble(),
            value: widget.gameViewModel.amountValues.value.toDouble(),
            max: GameViewModel.MAX_AMOUNT_OF_VALUES_DEFAULT.toDouble(),
            onChanged: widget.gameViewModel.setAmountValues,
          ),
        ),
        Text(GameViewModel.MAX_AMOUNT_OF_VALUES_DEFAULT.toString())
      ],
    );
  }

  Wrap buildWrap() {
    return Wrap(
      spacing: 40,
      children: [
        for (var controller in widget.gameViewModel.controllers)
          TweenAnimationBuilder(
            builder: (_, double value, Widget? child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            duration: const Duration(milliseconds: 1000),
            tween: Tween(begin: 0.0, end: 1.0),
            child: Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Utils.getColorAccordingTheme(context)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration.collapsed(hintText: ''),
                style: TextStyle(
                    color: Utils.getColorAccordingTheme(context), fontSize: 32),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                      RegExp('^(?:[1-9]|[1-5][0-9]|60)\$'))
                ],
                cursorColor: Colors.transparent,
                cursorWidth: 0,
              ),
            ),
          )
      ],
    );
  }
}
