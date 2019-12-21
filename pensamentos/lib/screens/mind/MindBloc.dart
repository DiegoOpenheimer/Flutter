
import 'dart:async';

import 'package:pensamentos/model/Quote.dart';
import 'package:pensamentos/model/QuoteManager.dart';

class MindBloc {

  QuoteManager _quoteManager = QuoteManager();
  StreamController<Quote> _controller = StreamController();

  Stream<Quote> get listener => _controller.stream;

  void executeQuote() async {
    Quote quote = await _quoteManager.random();
    _controller.add(quote);
  }

  void dispose() {
    _controller?.close();
  }

}