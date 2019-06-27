import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/services/connectionNetwork.dart';
import 'package:marvel/services/marvelAPI.dart';
import 'package:marvel/widgets/home/HomeWidget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:marvel/widgets/informationCharacter/InformationWidget.dart';

import 'blocs/MarvelBloc.dart';
import 'blocs/ThemeBloc.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  MyApp() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {

    ThemeBloc themeBloc = ThemeBloc();

    return BlocProvider(
      blocs: [
        Bloc((i) => themeBloc),
        Bloc((i) => MarvelBloc(i.get<MarvelAPI>(), i.get<ConnectionNetwork>()))
      ],
      dependencies: [
        Dependency((i) => MarvelAPI()),
        Dependency((i) => ConnectionNetwork())
      ],
      child: StreamBuilder(
        stream: themeBloc.outTheme,
        builder: (context, asyncSnapshot) {
          HandlerTheme handlerTheme = asyncSnapshot.data;
          return CupertinoApp(
              theme: CupertinoThemeData(brightness: handlerTheme == HandlerTheme.dark ? Brightness.dark :  Brightness.light),
              routes: <String, WidgetBuilder>{
                '/': (context) => HomeWidget(),
                '/information': (context) => InformationWidget()
              }
          );
        },
      ),
    );
  }

}
