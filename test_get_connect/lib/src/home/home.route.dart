
import 'package:get/route_manager.dart';
import 'package:test_get_connect/app.route.dart';
import 'package:test_get_connect/src/home/home.bindings.dart';
import 'home.widget.dart';

class HomeRoute implements Route {

  @override
  List<GetPage> routes() {
    return [
      GetPage(name: '/', page: () => HomeWidget(), binding: HomeBindings())
    ];
  }

}