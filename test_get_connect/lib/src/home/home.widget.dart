import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'home.controller.dart';

class HomeWidget extends StatelessWidget {
  
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Container(
        width: Get.width,
        child: _body()
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _cupertinoButton(title: 'Repositories', onPress: () => Get.toNamed('/github')),
        SizedBox(height: 16),
        _cupertinoButton(title: 'Emotions Github', onPress: () => Get.toNamed('/emotions'))
      ],
    );
  }

  Widget _cupertinoButton({ @required String title, @required Function onPress }) {
    assert(title != null);
    assert(onPress != null);

    return SizedBox(
      width: 200,
      child: CupertinoButton.filled(
        padding: const EdgeInsets.all(0),
        child: Text(title),
        onPressed: onPress
      ),
    );
  }

}