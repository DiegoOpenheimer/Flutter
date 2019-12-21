import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pensamentos/model/Quote.dart';
import 'package:pensamentos/screens/mind/MindBloc.dart';

import 'components/TransitionQuote.dart';

class MindWidget extends StatefulWidget {

  @override
  _MindWidgetState createState() => _MindWidgetState();
}

class _MindWidgetState extends State<MindWidget> {


  final MindBloc _bloc = MindBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _bloc.executeQuote,
      child: CupertinoPageScaffold(
        child: _build(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc.executeQuote();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Widget _build() {
    return StreamBuilder<Quote>(
      stream: _bloc.listener,
      builder: (context, snapshot) {
        Quote quote = snapshot?.data;
        if (quote != null) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(quote.image, fit: BoxFit.cover,),
              _effectBlur(),
              Positioned.fill(child: TransitionQuote(quote))
            ],
          );
        }
        return Container();
      }
    );
  }

  Positioned _effectBlur() {
    return Positioned.fill(
       child: BackdropFilter(
         filter: ImageFilter.blur(
           sigmaX: 20,
           sigmaY: 20
         ),
         child: Container(
           color: Colors.white.withOpacity(0.5),
         ),
       ),
     );
  }
}
