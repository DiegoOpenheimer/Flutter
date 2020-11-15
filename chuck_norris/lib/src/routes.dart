import 'package:get/get.dart';
import 'package:chuck_norris/src/home/home.route.dart' as homeRoute;
import 'package:chuck_norris/src/random/random.route.dart' as randomRoute;
import 'package:chuck_norris/src/categories/categories.routes.dart' as categoriesRoute;

List<GetPage> routes = [
  ...homeRoute.routes,
  ...randomRoute.routes,
  ...categoriesRoute.routes,
];