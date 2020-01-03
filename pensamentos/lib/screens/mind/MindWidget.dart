import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/model/Quote.dart';
import 'package:pensamentos/screens/home/HomeBloc.dart';
import 'package:pensamentos/screens/mind/MindBloc.dart';
import 'package:pensamentos/services/Configuration.dart';
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
  StreamSubscription _subscriptionStateApp;

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
    _subscriptionStateApp = _homeBloc.listenerStateApp.listen((state) async {
      if (state == AppLifecycleState.resumed) {
        await _bloc.reload().catchError((e) => null);
        _bloc.executeQuote();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _subscriptionTabs?.cancel();
    _subscriptionStateApp?.cancel();
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
              Positioned.fill(child: SafeArea(child: _transitionInformation(quote)))
            ],
          );
        }
        return Container();
      }
    );
  }

  Widget _transitionInformation(Quote quote) {
    return StreamBuilder(
      stream: _bloc.listenerSegment,
      builder: (context, snapshot) {
        return TransitionQuote(
          quote,
          fontColor: _bloc.valueSegment != ValueConfiguration.defaultSegment ? Colors.white : null,
        );
      },
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
             int value = _bloc.valueSegment ?? ValueConfiguration.defaultSegment;
             Color color = value == ValueConfiguration.defaultSegment ?
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
