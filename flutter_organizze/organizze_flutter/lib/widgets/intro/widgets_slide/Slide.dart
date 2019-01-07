import 'package:flutter/material.dart';

class SlideWidget extends StatelessWidget {

  String image;
  String description;
  String message;

  SlideWidget({
      this.image,
      this.description,
      this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, height: 200,width: 200,),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          Text(message)
        ].where((Widget widget) => widget != null).toList(),
      ),
    );
  }
}
