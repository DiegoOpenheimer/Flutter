import 'package:flutter/material.dart';
import 'package:my_game/model/GameProvider.dart';
import 'package:my_game/screens/details/GameDetails.dart';
import 'package:my_game/screens/game/GameWidget.dart';
import 'package:my_game/screens/home/HomeWidget.dart';
import 'package:my_game/shared/constants.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Game',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }
        ),
        primaryColor: CustomColor.main,
        buttonColor: CustomColor.main,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
        )
      ),
      routes: <String, WidgetBuilder> {
        '/': (context) => HomeWidget(),
      },
      onGenerateRoute: (RouteSettings settings) {
        Map screens = {
          '/add-edit-game': () => MaterialPageRoute<Game>(
            builder: (_) => GameWidget(game: settings.arguments,)
          ),
          '/game-detail': () => MaterialPageRoute(
            builder: (_) => GameDetailWidget(settings.arguments,)
          )
        };
        return screens[settings.name]();
      },
    );
  }
}
