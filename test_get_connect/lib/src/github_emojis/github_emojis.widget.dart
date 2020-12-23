import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.controller.dart';
import 'package:transparent_image/transparent_image.dart';

import 'github_emojis.model.dart';

class GithubEmojisWidget extends GetView<GithubEmojisController> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Emotions'),
        previousPageTitle: 'Home',
      ),
      child: _body(),
    );
  }

  Widget _body() {
    return controller.obx(
      (state) => _list(state),
      onError: (value) => Center(child: Text(value),),
      onLoading: Center(child: CupertinoActivityIndicator())
    );
  }

  Widget _list(List<Emojis> list) {
    return CupertinoScrollbar(
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: list[index].url,
          );
        },
      ),
    );
  }
}