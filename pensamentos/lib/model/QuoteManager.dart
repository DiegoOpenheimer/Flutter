

import 'dart:convert';
import 'dart:math';

import 'package:pensamentos/model/Quote.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuoteManager {

  List<Quote> quotes = List();

  Future _initialize() async {
    String value = await rootBundle.loadString('assets/files/quotes.json');
    jsonDecode(value)?.forEach((value) => quotes.add(Quote.fromMap(value)));
  }

  Future<Quote> random() async {
    if (quotes.isEmpty) {
      await _initialize();
    }
    int index = Random().nextInt(quotes.length);
    return quotes[ index ];
  }

}