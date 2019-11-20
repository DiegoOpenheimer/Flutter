import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/components/CustomNavigationBar.dart';

class AddTodoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildBody(),
      navigationBar: CustomNavigationBar(title: 'Add Todo',),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
