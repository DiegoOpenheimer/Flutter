import 'package:chuck_norris/src/random/random.model.dart';
import 'package:chuck_norris/src/random/random.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandomWidget extends StatelessWidget {

  final RandomViewModel _randomViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chuck Norris'), actions: [
        IconButton(icon: Icon(Icons.update), onPressed: _randomViewModel.loadData)
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
        Obx(_buildInformation)
      ],
    );
  }

  Widget _buildInformation() {
    if (_randomViewModel.isLoading.value) {
      return CircularProgressIndicator();
    }
    if (_randomViewModel.error.value.isNotEmpty) {
      return Text(_randomViewModel.error.value);
    }
    final Random random = _randomViewModel.random.value;
    String date = "";
    if (random.updatedAt != null) {
      date = "${random.updatedAt.day.toString().padLeft(2, "0")}/${random.updatedAt.month.toString().padLeft(2, "0")}/${random.updatedAt.year}";
    }
    return Column(
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
          tween: Tween(begin: 100.0, end: 0.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: value <= 80 ? 1 : 0,
                child: child,
              ),
            );
          },
          child: Text(random?.value ?? "", style: Theme.of(Get.context).textTheme.headline5, textAlign: TextAlign.justify,)
        ),
        SizedBox(height: 16,),
        Text(date, style: Theme.of(Get.context).textTheme.headline6, textAlign: TextAlign.center,)
      ],
    );
  }
}