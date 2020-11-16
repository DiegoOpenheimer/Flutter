import 'package:chuck_norris/src/shared/services/Shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedComponent extends StatelessWidget {
  final bool checked;
  final Rx observable;
  final String text;

  SharedComponent(this.observable, {this.checked, this.text});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: checked != null ? checked : observable.value != null,
        child: IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Get.find<CustomShared>().sharedWithImage(
                  path: 'assets/imgs/chuck-norris.png',
                  text: observable.value?.value ?? text);
            }),
      );
    });
  }
}
