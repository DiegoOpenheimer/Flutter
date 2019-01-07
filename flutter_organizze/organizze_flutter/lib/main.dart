import 'package:flutter/material.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/Register.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/login.dart';
import 'package:organizze_flutter/widgets/Revenue_and_Expense/EntityWidget.dart';
import 'package:organizze_flutter/widgets/home/HomeWidget.dart';
import 'package:organizze_flutter/widgets/intro/intro-widget.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizze',
      theme: ThemeData(
        accentColor: Color(0xffff706a),
        primaryColorDark: Color(0xff00b2bc),
        primaryColor: Color(0xff01c7d2),
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light,
        accentColorBrightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => IntroWidget(),
        '/login': (context) => LoginWidget(),
        '/home': (context) => HomeWidget(),
        '/register': (context) => RegisterWidget(),
        '/revenue': (context) => EntityWidget(operation: 'revenue',),
        '/expense': (context) => EntityWidget(operation: 'expense',)
      }
    );
  }
}
