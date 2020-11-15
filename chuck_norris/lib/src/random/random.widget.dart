import 'package:chuck_norris/src/shared/components/message.dart';
import 'package:chuck_norris/src/shared/model/message.model.dart';
import 'package:chuck_norris/src/random/random.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandomWidget extends StatefulWidget {

  @override
  _RandomWidgetState createState() => _RandomWidgetState();
}

class _RandomWidgetState extends State<RandomWidget> {

  final RandomViewModel _randomViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    _randomViewModel.loadData(query: Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chuck Norris'), actions: [
        IconButton(icon: Icon(Icons.update), onPressed: () => _randomViewModel.loadData(query: Get.arguments))
      ], automaticallyImplyLeading: false,),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: Get.width,
        child: _body()
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/imgs/chuck-norris.png'),
        SizedBox(height: 16,),
        Obx(_buildInformation),
        SizedBox(height: 16,)
      ],
    );
  }

  Widget _buildInformation() {
    if (_randomViewModel.loading.value) {
      return CircularProgressIndicator();
    }
    if (_randomViewModel.error.value.isNotEmpty) {
      return Text(_randomViewModel.error.value);
    }
    final Message random = _randomViewModel.random.value;
    return MessageWidget(message: random,);
  }
}