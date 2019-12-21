import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/model/Quote.dart';
import 'package:pensamentos/screens/home/HomeBloc.dart';
import 'package:pensamentos/screens/mind/MindBloc.dart';
import 'package:pensamentos/shared/constants.dart';

import 'components/TransitionQuote.dart';

class MindWidget extends StatefulWidget {

  @override
  _MindWidgetState createState() => _MindWidgetState();
}

class _MindWidgetState extends State<MindWidget> {


  final MindBloc _bloc = MindBloc();
  final HomeBloc _homeBloc = HomeBloc();
  StreamSubscription _subscriptionTabs;


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
    _subscriptionTabs = _homeBloc.listenerTabs.listen((value) {
      if (value == 0) {
        _bloc.executeQuote();
      } else {
        _bloc.stopTimer();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _subscriptionTabs?.cancel();
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
              Positioned.fill(child: SafeArea(child: TransitionQuote(quote, fontColor: _bloc.valueSegment != 0 ? Colors.white : null,)))
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
         child: StreamBuilder<int>(
           stream: _bloc.listenerSegment,
           builder: (context, _) {
             int value = _bloc.valueSegment ?? 0;
             Color color = value == 0 ?
              Colors.white.withOpacity(.5) :
              Constants.color.withOpacity(.5);
             return Container(
               color: color,
             );
           }
         ),
       ),
     );
  }
}
