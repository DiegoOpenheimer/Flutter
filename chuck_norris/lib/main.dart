import 'package:chuck_norris/src/AppBindings.dart';
import 'package:chuck_norris/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(ChuckNorrisApp());

class ChuckNorrisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chuck norris',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(accentColor: Colors.orange[900]),
      initialBinding: ChuckNorrisBindings(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(headline5: TextStyle(color: Colors.black)),
              iconTheme: IconThemeData(color: Colors.black)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.orange[900]),
      getPages: routes,
    );
  }
}
