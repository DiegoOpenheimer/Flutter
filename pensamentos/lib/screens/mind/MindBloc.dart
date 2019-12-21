
import 'dart:async';

import 'package:pensamentos/model/Quote.dart';
import 'package:pensamentos/model/QuoteManager.dart';
import 'package:pensamentos/services/Configuration.dart';
import 'package:rxdart/rxdart.dart';

class MindBloc {


  Configuration _configuration = Configuration();
  QuoteManager _quoteManager = QuoteManager();

  StreamSubscription _timer;

  PublishSubject<Quote> _controller = PublishSubject();
  Stream<Quote> get listener => _controller.stream;

  PublishSubject<int> _controllerSegment = PublishSubject();
  Stream<int> get listenerSegment => _controllerSegment.stream;
  int valueSegment = 0;

  Future executeQuote() async {
    Quote quote = await _quoteManager.random();
    _controller.add(quote);
    init();
  }

  Future init() async {
    _timer?.cancel();
    valueSegment = await _configuration.segment;
    _controllerSegment.add(valueSegment);
    if (await _configuration.automatic) {
      _timer = Stream.periodic(Duration(seconds: (await _configuration.timer).toInt())).listen((_) async {
         Quote quote = await _quoteManager.random();
         _controller.add(quote);
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    _controller?.close();
    _controllerSegment?.close();
  }

}