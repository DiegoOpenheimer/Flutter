import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_get_connect/app.bindinds.dart';
import 'package:test_get_connect/app.route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'Test_get_connect',
      theme: CupertinoThemeData(brightness: Brightness.light),
      getPages: AppRoute.buildRoutes(),
      initialBinding: AppBindings(),
    );
  }
}