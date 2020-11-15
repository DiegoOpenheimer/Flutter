import 'package:chuck_norris/src/shared/model/message.model.dart';
import 'package:flutter/material.dart';
import 'package:chuck_norris/src/shared/utils/extensions_date.dart';

class MessageWidget extends StatelessWidget {

  final Message message;

  MessageWidget({ @required this.message }) :
  assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
          tween: Tween(begin: 100.0, end: 0.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: value <= 80 ? 1 : 0,
                child: child,
              ),
            );
          },
          child: Text(message?.value ?? "", style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.justify,)
        ),
        SizedBox(height: 16,),
        Text(message?.updatedAt?.formatterDate ?? "", style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center,)
      ],
    );
  }

}