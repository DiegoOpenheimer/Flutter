import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  String label;
  Icon icon;

  TextInput({ this.label, this.icon });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    String label = widget.label;
    Icon icon = widget.icon;
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      highlightColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedBuilder(
              animation: _focusNode,
              builder: (context, child) {
                return Text( label ?? 'Field', style: TextStyle(color: _focusNode.hasFocus ? Colors.amber : Colors.white), );
              },
            ),
            SizedBox(height: 10,),
            TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                  prefixIcon: icon,
                  contentPadding: EdgeInsets.all(0),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  )
              ),
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

