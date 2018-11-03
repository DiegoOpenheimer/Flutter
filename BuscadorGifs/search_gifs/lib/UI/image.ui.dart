import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ImageView extends StatelessWidget {

  Map gif;

  ImageView({@required this.gif});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(gif['title'], style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.share, color: Colors.white,), onPressed: () => shareImage())
        ],
      ),
      backgroundColor: Colors.black,
      body: buidBody(context),
    );
  }
  
  Widget buidBody(BuildContext context) {
    return new Center(
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: 500.0,
        child: new Image.network(gif['images']['fixed_height']['url'], fit: BoxFit.contain),
      )
    );
  }

  void shareImage() {
    Share.share(gif['images']['fixed_height']['url']);
  }
}
