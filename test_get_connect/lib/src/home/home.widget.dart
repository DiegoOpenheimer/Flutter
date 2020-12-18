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
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => Get.toNamed('/github'),
          child: Icon(CupertinoIcons.add)
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _body(),
          _buildFloatingButton()
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Text('Counter: ${controller.counter}');
        }),
        SizedBox(height: 16),
        CupertinoButton.filled(
          child: Text('GithubPage'),
          onPressed: () => Get.toNamed('/github')
        )
      ],
    );
  }

  Widget _buildFloatingButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.increment,
        ),
      ),
    );
  }


}