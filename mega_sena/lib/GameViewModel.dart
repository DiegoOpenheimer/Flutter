import 'dart:math';

import 'package:flutter/material.dart';

import 'entities/Game.dart';

class GameViewModel {
  static const int AMOUNT_OF_VALUES_DEFAULT = 6;
  static const int MAX_AMOUNT_OF_VALUES_DEFAULT = 10;
  static const int MAX_NUMBER_GAMES = 60;
  static final GameViewModel _instance = GameViewModel._internal();

  ValueNotifier<int> amountValues = ValueNotifier(AMOUNT_OF_VALUES_DEFAULT);
  List<TextEditingController> controllers = [];
  ValueNotifier<List<Game>> games = ValueNotifier([]);
  ValueNotifier<List<String>> generatedValues = ValueNotifier([]);

  GameViewModel._internal() {
    for (int i = 0; i < AMOUNT_OF_VALUES_DEFAULT; i++) {
      controllers.add(TextEditingController());
    }
  }

  factory GameViewModel() => _instance;

  void clearFields() {
    controllers.forEach((controller) {
      controller.clear();
    });
  }

  void setAmountValues(double amountValues) {
    int value = amountValues.toInt() - this.amountValues.value;
    if (amountValues.toInt() < controllers.length) {
      while (amountValues.toInt() < controllers.length) {
        controllers.removeLast();
      }
    } else {
      for (int i = 0; i < value; i++) {
        controllers.add(TextEditingController());
      }
    }
    this.amountValues.value = amountValues.toInt();
  }

  void generated() {
    var values = Set<String>();
    controllers.forEach((element) {
      if (element.value.text.isNotEmpty) {
        values.add(element.value.text);
      }
    });
    var random = Random();
    while (values.length < amountValues.value) {
      values.add((random.nextInt(MAX_NUMBER_GAMES) + 1).toString());
    }
    generatedValues.value = values.toList();
  }
}
