

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class Alert {

  static void showActionSheet(context, { Function(ImageSource) onComplete }) {
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                onTap: () {
                  onComplete(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.camera),
                title: Text('Camera'),
              ),
              SizedBox(height: 8,),
              ListTile(
                onTap: () {
                  onComplete(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.photo_library),
                title: Text('Biblioteca de fotos'),
              ),
              SizedBox(height: 8,),
              FlatButton(
                onPressed: Navigator.of(context).pop,
                child: Text('Cancelar', style: TextStyle(color: Colors.red, fontSize: 18), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 8,),
            ],
          ),
        ],
      );
    });
  }


}