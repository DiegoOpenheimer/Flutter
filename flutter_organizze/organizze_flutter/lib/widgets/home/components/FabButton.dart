import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class FabButtonWidget extends StatelessWidget {

  UnicornDialer _unicornDialer;

  @override
  Widget build(BuildContext context) {
    _unicornDialer = UnicornDialer(
        hasBackground: false,
        parentButtonBackground: Colors.redAccent,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add, color: Colors.white,),
        childButtons: initializeFabButton(context)
    );
    return _unicornDialer;
  }

  List<UnicornButton> initializeFabButton(BuildContext context) {
    List<UnicornButton> childButtons = List();
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Receita",
        labelColor: Colors.white,
        labelBackgroundColor: Colors.black.withOpacity(0.5),
        currentButton: FloatingActionButton(
          heroTag: "receita",
          backgroundColor: Color(0xFF00D39E),
          mini: true,
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            Navigator.pushNamed(context, '/revenue');
          },
      )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Despesa",
        labelColor: Colors.white,
        labelBackgroundColor: Colors.black.withOpacity(0.5),
        currentButton: FloatingActionButton(
          heroTag: "despesa",
          backgroundColor: Color(0xFFFF7064),
          mini: true,
          child: Icon(Icons.remove, color: Colors.white,),
          onPressed: () {
           Navigator.pushNamed(context, '/expense');
          },
      )));
    return childButtons;
  }

  bool isOpen() => _unicornDialer.state.isOpen();

  void handlerButton() => _unicornDialer.state.mainActionButtonOnPressed();

}
