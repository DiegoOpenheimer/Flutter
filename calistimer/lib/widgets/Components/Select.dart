import 'package:flutter/material.dart';

typedef void CallbackSelect(int index, String value);

class ComponentSelect extends StatefulWidget {

  String label;
  List<String> options;
  int selected;
  CallbackSelect onSelected;

  ComponentSelect({
    this.label = '',
    this.options,
    this.selected = 0,
    this.onSelected,
  }) {
    assert(options != null && options.isNotEmpty);
  }

  @override
  _ComponentSelectState createState() => _ComponentSelectState();
}

class _ComponentSelectState extends State<ComponentSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.label, style: TextStyle(color: Colors.white, fontSize: 20),),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _options(),
        )
      ],
    );
  }
  
  List<Widget> _options() {
    return widget.options.map((String option) {
      int index = widget.options.indexOf(option);
      return Material(
        color: widget.selected == index ? Colors.white : Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child:
        InkWell(
          onTap: () {
            setState(() {
              widget.selected = index;
              if (widget.onSelected != null) {
                widget.onSelected(index, option);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Text(option, style: TextStyle(color: widget.selected == index ? Colors.black : Colors.white),),
          )
        ),
      );
    }).toList();
  }
}
