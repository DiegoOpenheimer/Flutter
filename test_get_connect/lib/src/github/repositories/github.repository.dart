import 'package:test_get_connect/src/github/model/repository.dart';

abstract class GitHubRepository {

  Future<List<Repository>> getRepositories(String name);

}