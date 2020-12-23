

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test_get_connect/app.route.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.bindings.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.widget.dart';

class GithubEmojisRoute extends Route {
  @override
  List<GetPage> routes() {
    return [
      GetPage(name: '/emotions', page: () => GithubEmojisWidget(), binding: GithubEmojisBindings())
    ];
  }
}