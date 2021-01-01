import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_get_connect/src/github_repositories/model/repository.dart';

typedef OnPress = void Function(Repository);

class GitHubListWidget extends StatelessWidget {

  final List<Repository> repositories;
  final OnPress onPress;

  GitHubListWidget({ this.repositories = const [], this.onPress });

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: repositories.isNotEmpty ?  _buildListView() : _emptyMessage(),
    );
  }

  Widget _emptyMessage() {
    return Center(
      child: Text('Without inforation...'),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (BuildContext context, int index) {
        return _item(repositories[index]);
      },
    );
  }

  Widget _item(Repository repository) {
    return Material(
        color: Colors.transparent,
        child: ListTile(
        title: Text(repository.name),
        subtitle: Text(repository.fullName),
        onTap: () { onPress?.call(repository);},
      ),
    );
  }
}