import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mega_sena/home/HomeWidget.dart';

void main() {
  testWidgets("Test HomeWidget page", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeWidget(),
    ));

    final Finder titleCreateGame = find.text('Mega Sena');

    expect(find.byIcon(Icons.create), findsOneWidget);

    await tester.tap(find.byIcon(Icons.create));

    expect(titleCreateGame, findsOneWidget);
  });
}