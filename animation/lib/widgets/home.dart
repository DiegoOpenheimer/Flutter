import 'package:animation/widgets/components/ButtonAnimated.dart';
import 'package:animation/widgets/components/TextInput.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {

  @override
  State createState() => HomeState();

}

class HomeState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height,
      child: _mountStaticWidget(),
    ),
  );
  }

  Widget _mountStaticWidget() {
    return Column(
      children: <Widget>[
        SizedBox(height: 100,),
        Icon(Icons.check, size: 120,),
        TextInput(label: 'Name'),
        TextInput(label: 'NickName',),
        Expanded(child: Container(),),
        ButtonAnimatedWidget(),
        Expanded(child: Container(),),
        FlatButton(child: Text('Esqueci minha senha'), onPressed: () {},)
      ],
    );
  }

}