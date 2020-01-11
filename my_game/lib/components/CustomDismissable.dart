import 'package:flutter/material.dart';

class CustomDismissable extends StatelessWidget {

  final String id;
  final Widget child;
  final Function(DismissDirection) onDismiss;

  CustomDismissable({ @required this.id, @required this.child, @required this.onDismiss }) :
  assert(child != null),
  assert(id != null),
  assert(onDismiss != null);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white,),
      ),
      key: Key(id),
      onDismissed: onDismiss,
      child: child,
    );
  }
}