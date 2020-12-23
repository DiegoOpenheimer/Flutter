import 'package:get/route_manager.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.route.dart';
import 'package:test_get_connect/src/github_repositories/github.route.dart';
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
      ...GitHubRepositoryRoute().routes(),
      ...GithubEmojisRoute().routes()
    ];
  }


}