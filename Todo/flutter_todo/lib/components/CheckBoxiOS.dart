import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxiOS extends StatelessWidget {

  final bool checked;
  final Function(bool) onChanged;

  CheckBoxiOS({ this.checked = false, this.onChanged });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged(!checked);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: checked ? CupertinoColors.activeBlue : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: CupertinoColors.activeBlue, width: 1)
        ),
        child: checked ?
        FittedBox(fit: BoxFit.cover, child: Icon(CupertinoIcons.check_mark, color: Colors.white, size: 50,),) :
        Container(),
      ),
    );
  }
}
