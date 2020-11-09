

import 'package:chuck_norris/src/random/random.model.dart';

abstract class RandomRepository {

  Future<Random> getRandom();

  void dispose();

}