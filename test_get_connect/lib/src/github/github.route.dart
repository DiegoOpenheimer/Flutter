import 'package:get/route_manager.dart';
import 'package:test_get_connect/app.route.dart';
import 'package:test_get_connect/src/github/github.widget.dart';
import 'github.bindinds.dart';

class GitHubRoute implements Route {

  @override
  List<GetPage> routes() {
    return [
      GetPage(name: '/github', page: () => GitHubWidget(), binding: GitHubBinding())
    ];
  }


}