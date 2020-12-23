import 'dart:async';
import 'package:test_get_connect/src/core/services/http.service.dart';
import 'package:test_get_connect/src/github_repositories/model/repository.dart';
import 'github.repository.dart';

class GitHubRepositoryImpl implements GitHubRepository {

  final Http http;

  GitHubRepositoryImpl(this.http);

  Future<List<Repository>> getRepositories(String name) async {
    return http.handleGet<List<Repository>>(
      '/users/$name/repos',
      decoder: (response) {
        try {
          var value = response?.map<Repository>((json) => Repository.fromJson(json))?.toList() ?? [];
          return value;
        } catch (e) {
          return [];
        }
      },
    );
  }

}