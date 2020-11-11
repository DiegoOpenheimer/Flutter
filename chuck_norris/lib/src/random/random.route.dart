import 'package:chuck_norris/src/random/random.bindings.dart';
import 'package:chuck_norris/src/random/random.widget.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: '/random', page: () => RandomWidget(), binding: RandomBinding()),
];
