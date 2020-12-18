

import 'package:get/route_manager.dart';
import 'package:test_get_connect/src/github/github.route.dart';
import 'package:test_get_connect/src/home/home.route.dart';

abstract class Route {

  List<GetPage> routes();

}

class AppRoute implements Route {

  static List<GetPage> buildRoutes() {
    AppRoute appRoute = AppRoute();
    return appRoute.routes();
  }

  @override
  List<GetPage> routes() {
    return [
      ...HomeRoute().routes(),
      ...GitHubRoute().routes(),
    ];
  }


}