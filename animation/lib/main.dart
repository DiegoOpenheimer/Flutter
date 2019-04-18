import 'package:animation/widgets/home.dart';
import 'package:animation/widgets/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white)
        ),
        routes: {
          '/': (context) => HomeWidget()
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/information') {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              transitionsBuilder: (context, animation1, animation2, child) {
                return FadeTransition(
                  child: child,
                  opacity: animation1,
                );
              },
              pageBuilder: (context, animation1, animation2) {
                return InformationWidget();
              }
            );
          }
        },
      );
  }

}