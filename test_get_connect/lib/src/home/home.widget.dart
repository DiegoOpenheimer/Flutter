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
        middle: Text('Home')
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
        SizedBox(height: 16),
        CupertinoButton.filled(
          child: Text('GithubPage'),
          onPressed: () => Get.toNamed('/github')
        )
      ],
    );
  }

}