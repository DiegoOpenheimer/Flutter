import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:try_bloc_pattern/services/GraphQLClient.dart';
import 'package:try_bloc_pattern/widgets/HomeWidget.dart';
import 'package:try_bloc_pattern/widgets/MessageWidget/BlocMessage.dart';
import 'package:try_bloc_pattern/widgets/MessageWidget/MessageWidget.dart';

import 'BlocIncrement.dart';
import 'BlocTheme.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  BlocTheme bloc = BlocTheme();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => bloc),
        Bloc((i) => BlocIncrement()),
        Bloc((i) => BlocMessage(i.get<GraphQLClient>()))
      ],
      dependencies: [
        Dependency((i) => GraphQLClient())
      ],
      child: StreamBuilder(
          stream: bloc.listenerTheme,
          builder: (context, asyncSnapshot) {
            ThemeData theme = asyncSnapshot.data;
            return MaterialApp(
              theme: theme,
              routes: <String, WidgetBuilder>{
                '/': (context) => HomeWidget(),
                '/messages': (context) => MessageWidget()
              },
            );
          }
      ),
    );
  }
}
