import 'package:test_get_connect/src/core/services/http.service.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.model.dart';

class GithubEmojisRepository {

  final Http http;

  GithubEmojisRepository(this.http);

  Future<List<Emojis>> getEmojis() async {
    return http.handleGet(
      '/emojis',
      decoder: (response) {
        Map values = response as Map;
        List<Emojis> emojis = [];
        values.entries.forEach((element) {
          emojis.add(Emojis(name: element.key, url: element.value));
        });
        return emojis;
      }
    );
  }

}