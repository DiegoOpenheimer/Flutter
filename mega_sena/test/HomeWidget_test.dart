import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mega_sena/home/HomeWidget.dart';

void main() {
  testWidgets("Test HomeWidget page", (WidgetTester tester) async {
    final PageController pageController = PageController();
    await tester.pumpWidget(MaterialApp(
      home: HomeWidget(pageController),
    ));

    final Finder titleCreateGame = find.text('Mega Sena');

    expect(titleCreateGame, findsOneWidget);
    expect(find.byIcon(Icons.create), findsOneWidget);

    final Finder pageView = find.byType(PageView);

    expect(pageView, findsOneWidget);

    pageController.jumpToPage(1);

    await tester.pump();

    expect(find.text('Criar jogo'), findsOneWidget);
    expect(find.text('Se quiser, você pode informar valores para serem inclusos no sorteio'), findsOneWidget);
  });
}