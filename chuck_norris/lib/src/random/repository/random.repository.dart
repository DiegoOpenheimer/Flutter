
import 'package:chuck_norris/src/shared/model/message.model.dart';

abstract class RandomRepository {

  Future<Message> getRandom({ String query });

  void dispose();

}