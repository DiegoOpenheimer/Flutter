import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/shared/constants.dart';

class ConsolesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Plataformas', color: CustomColor.secondary,),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container();
  }
}
