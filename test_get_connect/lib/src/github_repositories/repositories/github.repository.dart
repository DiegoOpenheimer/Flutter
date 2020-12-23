import 'package:test_get_connect/src/github_repositories/model/repository.dart';

abstract class GitHubRepository {

  Future<List<Repository>> getRepositories(String name);

}